import 'package:common/arch/data/local/dao/account_dao.dart';
import 'package:common/arch/data/local/dao/pregnancy_dao.dart';
import 'package:common/arch/data/local/db/app_db.dart';
import 'package:common/arch/data/local/source/pregnancy_local_source.dart';
import 'package:common/arch/domain/dummy_data.dart';
import 'package:common/arch/domain/model/auth.dart';
import 'package:common/arch/domain/model/child.dart';
import 'package:common/arch/domain/model/father.dart';
import 'package:common/arch/domain/model/mother.dart';
import 'package:common/arch/domain/model/profile_data.dart';
import 'package:common/value/const_values.dart';
import 'package:common/value/db_const.dart';
import 'package:core/domain/model/result.dart';
import 'package:core/util/_consoles.dart';
import 'package:email_validator/email_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:collection/collection.dart';

mixin AccountLocalSrc {
  //Future<Result<bool>> saveSignupData(SignUpData signup); //For now, `SignUpData` is saved as batch with other data type.
  Future<Result<bool>> saveBatchProfile({
    required int userId,
    required int userRole,
    required SignUpData signup,
    required Mother mother,
    required Father father,
    required List<Child> children,
    //required List<DateTime> motherHpl,
    required BatchProfileIds ids,
  });
  Future<Result<bool>> saveBatchProfileRaw({
    //required int userId,
    required int userRole,
    required SignUpData signup,
    required BatchProfileServer batchProfiles,
  });
  Future<Result<bool>> saveSession(SessionData data);
  Future<Result<bool>> deleteSession();
  /// Returns null if user hasn't logged in yet.
  Future<Result<SessionData?>> getSession();

  Future<Result<ProfileEntity>> getProfileByNik(String nik, { int? type });
  Future<Result<List<ProfileEntity>>> getProfilesByPregnancies(List<PregnancyEntity> pregnancies);

  Future<Result<int>> getCredentialIdByNik(String nik);

  Future<Result<String>> getMotherNik(String email);
  Future<Result<String>> getFatherNik(String email);
  Future<Result<Map<int, String>>> getChildrenNik(String email);

  Future<Result<List<Profile>>> getChildrenProfilesByMotherNik(String motherNik);

  Future<Result<int>> getMotherId(String nik);
  Future<Result<int>> getFatherId(String nik);
  Future<Result<int>> getChildId(String nik);

  Future<Result<Profile>> getProfile(String email);
  Future<Result<Profile>> getProfileByServerId(int serverId);

  Future<Result<bool>> saveCurrentEmail(String email);
  Future<Result<String>> getCurrentEmail();
  Future<Result<bool>> deleteCurrentEmail();

  Future<Result<bool>> clear();
}

class AccountLocalSrcImpl with AccountLocalSrc {
  final CredentialDao _credentialDao;
  final ProfileDao _profileDao;
  final PregnancyDao _pregnancyDao;
  final ProfileTypeDao _profileTypeDao;
  final SharedPreferences _sharedPref;
  final PregnancyLocalSrc _pregnancyLocalSrc;

  AccountLocalSrcImpl({
    required CredentialDao credentialDao,
    required ProfileDao profileDao,
    required PregnancyDao pregnancyDao,
    required ProfileTypeDao profileTypeDao,
    required SharedPreferences sharedPref,
    required PregnancyLocalSrc pregnancyLocalSrc,
  }):
    _credentialDao = credentialDao,
    _profileDao = profileDao,
    _pregnancyDao = pregnancyDao,
    _profileTypeDao = profileTypeDao,
    _sharedPref = sharedPref,
    _pregnancyLocalSrc = pregnancyLocalSrc
  ;

  @override
  Future<Result<bool>> saveBatchProfile({
    required int userId,
    required int userRole,
    required SignUpData signup,
    required Mother mother,
    required Father father,
    required List<Child> children,
    //required List<DateTime> motherHpl,
    required BatchProfileIds ids,
  }) async {
    final motherProf = ProfileEntity(
      userId: userId,
      type: DbConst.TYPE_MOTHER,
      name: mother.name,
      nik: mother.nik,
      birthDate: DateTime.parse(mother.birthDate),
      birthPlace: mother.birthCity,
      serverId: ids.motherId,
    );
    final fatherProf = ProfileEntity(
      userId: userId,
      type: DbConst.TYPE_FATHER,
      name: father.name,
      nik: father.nik,
      birthDate: DateTime.parse(father.birthDate),
      birthPlace: father.birthCity,
      serverId: ids.fatherId,
    );
    final childProfs = List<ProfileEntity>.generate(children.length, (i) {
      final child = children[i];
      final id = ids.childrenId[i];
      return ProfileEntity(
        userId: userId,
        type: DbConst.TYPE_CHILD,
        name: child.name,
        nik: child.nik,
        birthDate: DateTime.parse(child.birthDate),
        birthPlace: child.birthCity,
        serverId: id,
      );
    });

    return saveBatchProfileRaw(
      userRole: userRole,
      signup: signup,
      batchProfiles: BatchProfileServer(
        mother: motherProf,
        father: fatherProf,
        children: childProfs,
        motherHpl: null, //TODO: Consider to save hpl via this local src.
        pregnancies: [], //TODO: still unknown,
      ),
    );
  }

  @override
  Future<Result<bool>> saveBatchProfileRaw({
    //required int userId,
    required int userRole,
    required SignUpData signup,
    required BatchProfileServer batchProfiles,
  }) async {
    prind("saveBatchProfileRaw() batchProfiles= $batchProfiles");
    try {
      final credential = CredentialEntity(
        id: batchProfiles.mother.userId,
        name: signup.name,
        email: signup.email,
        role: userRole,
      );

      final profiles = [
        batchProfiles.mother,
        batchProfiles.father,
        ...batchProfiles.children
      ];

      final credRowId = await _credentialDao.insert(credential);
      if(credRowId < 0) {
        final msg = "Can't insert `credential` '$credential'";
        prinw(msg);
        return Fail(msg: msg);
      }
      await _profileDao.insertAll(profiles);
      await _pregnancyDao.insertAll(batchProfiles.pregnancies);
      /*
      final currentLatestPreg = batchProfiles.pregnancies.lastOrNull;
      if(currentLatestPreg != null) {
        final res = await _pregnancyLocalSrc.saveCurrentPregnancyId(currentLatestPreg.id);
        if(res is Fail<bool>) {
          final msg = "Can't save latest pregnancy in local";
          prinw(msg);
          return Fail(msg: msg);
        }
      }
       */

      return Success(true);
    } catch(e, stack) {
      final msg = "Error calling `saveBatchProfileRaw()`";
      prine("$msg, e= $e");
      prine(stack);
      return Fail(msg: msg, error: e);
    }
  }

  @override
  Future<Result<bool>> saveSession(SessionData data) async {
    try {
      await _sharedPref.setString(Const.KEY_SESSION, data.toAuthString());
      return Success(true);
    } catch(e) {
      return Fail();
    }
  }

  @override
  Future<Result<bool>> deleteSession() async {
    try {
      final res = await _sharedPref.remove(Const.KEY_SESSION);
      return Success(res);
    } catch(e) {
      return Fail();
    }
  }

  /// Returns null if user hasn't logged in yet.
  @override
  Future<Result<SessionData?>> getSession() async {
    try {
      final sessionStrList = _sharedPref.getString(Const.KEY_SESSION)?.split(" ");
      if(sessionStrList == null) {
        return Success(null);
      }
      final data = SessionData(tokenType: sessionStrList[0], token: sessionStrList[1],);
      return Success(data);
    } catch(e) {
      return Fail();
    }
  }

  @override
  Future<Result<ProfileEntity>> getProfileByNik(String nik, { int? type }) async {
    final profile = await _profileDao.getByNik(nik, type: type);
    if(profile == null) {
      return Fail();
    }
    return Success(profile);
  }
  @override
  Future<Result<List<ProfileEntity>>> getProfilesByPregnancies(List<PregnancyEntity> pregnancies) async {
    final list = <ProfileEntity>[];
    for(final preg in pregnancies) {
      final prof = await _profileDao.getByServerId(preg.id);
      if(prof == null) {
        prinw("Can't get profile with `serverId` of '${preg.id}', then continue to next iteration");
        continue;
      }
      list.add(prof);
    }
    return Success(list);
  }

  @override
  Future<Result<int>> getCredentialIdByNik(String nik) async {
    try {
      final res = await _profileDao.getCredentialIdByNik(nik);
      if(res == null) {
        return Fail(msg: "Can't get credetial id with `nik` of '$nik'");
      }
      return Success(res);
    } catch(e, stack) {
      final msg = "Error calling `getCredentialIdByNik()`";
      prine("$msg; e= $e");
      prine(stack);
      return Fail(msg: msg, error: e,);
    }
  }

  @override
  Future<Result<String>> getMotherNik(String email) async {
    final niks = await _profileDao.getNiksByEmail(email);
    final nik = niks[DbConst.TYPE_MOTHER]?.values.firstOrNull;
    if(nik != null) {
      return Success(nik);
    } else {
      return Fail();
    }
  }
  @override
  Future<Result<String>> getFatherNik(String email) async {
    final niks = await _profileDao.getNiksByEmail(email);
    final nik = niks[DbConst.TYPE_FATHER]?.values.firstOrNull;
    if(nik != null) {
      return Success(nik);
    } else {
      return Fail();
    }
  }
  @override
  Future<Result<Map<int, String>>> getChildrenNik(String email) async {
    try {
      prind("AccountLocalSrcImpl getChildNik() email = $email");
      final niks = await _profileDao.getNiksByEmail(email);
      prind("AccountLocalSrcImpl getChildNik() niks = $niks");
      final nik = niks[DbConst.TYPE_CHILD];
      if(nik != null) {
        return Success(nik);
      } else {
        return Fail();
      }
    } catch(e, stack) {
      prine(e);
      prine(stack);
      return Fail(error: e);
    }
  }

  @override
  Future<Result<List<Profile>>> getChildrenProfilesByMotherNik(String motherNik) async {
    try {
      final mother = await _profileDao.getByNik(motherNik, type: DbConst.TYPE_MOTHER);
      if(mother == null) {
        return Fail(msg: "Can't get mother profile with `motherNik` of '$motherNik' in `getChildrenProfilesByMotherNik()`");
      }
      final motherCred = await _credentialDao.getById(mother.userId);
      if(motherCred == null) {
        return Fail(msg: "Can't get mother credential with `id` of '${mother.userId}' in `getChildrenProfilesByMotherNik()`");
      }
      final res = await _profileDao.getProfilesByEmail(motherCred.email, type: DbConst.TYPE_CHILD);
      final children = res[DbConst.TYPE_CHILD]?.map((e) => Profile.fromEntity(
        entity: e, email: motherCred.email,
      )).toList(growable: false);
      if(children == null) {
        return Fail(msg: "Can't get children profiles with `id` of '${mother.userId}' in `getChildrenProfilesByMotherNik()`");
      }
      return Success(children);
    } catch(e, stack) {
      final msg = "Error calling `getChildrenProfilesByMotherNik()`";
      prine("$msg, e= $e");
      prine(stack);
      return Fail(msg: msg, error: e);
    }
  }

  @override
  Future<Result<int>> getMotherId(String nik) async {
    final ids = await _profileDao.getServerIdByNik(nik);
    final id = ids[DbConst.TYPE_MOTHER];
    if(id != null) {
      return Success(id);
    } else {
      return Fail();
    }
  }
  @override
  Future<Result<int>> getFatherId(String nik) async {
    final ids = await _profileDao.getServerIdByNik(nik);
    final id = ids[DbConst.TYPE_FATHER];
    if(id != null) {
      return Success(id);
    } else {
      return Fail();
    }
  }
  @override
  Future<Result<int>> getChildId(String nik) async {
    final ids = await _profileDao.getServerIdByNik(nik);
    final id = ids[DbConst.TYPE_CHILD];
    if(id != null) {
      return Success(id);
    } else {
      return Fail(msg: "`getChildId()` Can't get child id with nik = $nik");
    }
  }

  @override
  Future<Result<Profile>> getProfile(String email, { String? type }) async {
    final cred = await _credentialDao.getByEmail(email);
    final profRaw = await _profileDao.getProfilesByEmail(email);
    final prof = profRaw[type ?? DbConst.TYPE_MOTHER]?.firstOrNull;
    if(cred == null || prof == null) {
      return Fail();
    }
    final profile = Profile.fromEntity(entity: prof, email: email);
    return Success(profile);
  }
  @override
  Future<Result<Profile>> getProfileByServerId(int serverId) async {
    try {
      final prof = await _profileDao.getByServerId(serverId);
      if(prof == null) {
        final msg = "Can't get profile with `serverId` of '$serverId'";
        prinw(msg);
        return Fail(msg: msg, code: 1,);
      }
      final cred = await _credentialDao.getById(prof.userId);
      if(cred == null) {
        final msg = "Can't get user credential with `serverId` of '$serverId' and `prof.userId` of '${prof.userId}'";
        prine(msg);
        return Fail(msg: msg, code: 2,);
      }
      return Success(Profile.fromEntity(entity: prof, email: cred.email));
    } catch(e, stack) {
      final msg = "Error calling `getProfileByServerId()`";
      prine("$msg; e= $e");
      prine(stack);
      return Fail(msg: msg, error: e);
    }
  }

  @override
  Future<Result<bool>> saveCurrentEmail(String email) async {
    try {
      final res = await _sharedPref.setString(Const.KEY_ACTIVE_EMAIL, email);
      return Success(res);
    } catch(e) {
      return Fail();
    }
  }

  @override
  Future<Result<String>> getCurrentEmail() async {
    final email = _sharedPref.getString(Const.KEY_ACTIVE_EMAIL);
    if(email == null) {
      return Fail();
    }
    return Success(email);
  }

  @override
  Future<Result<bool>> deleteCurrentEmail() async {
    try {
      final res = await _sharedPref.remove(Const.KEY_ACTIVE_EMAIL);
      return Success(res);
    } catch(e) {
      return Fail();
    }
  }

  @override
  Future<Result<bool>> clear() async {
    try {
      final res = await _profileDao.deleteAll();
      final res2 = await _credentialDao.deleteAll();
      return Success(res > 0 && res2 > 0);
    } catch(e, stack) {
      prine(e);
      prine(stack);
      return Fail(msg: "Error calling `AccountLocalSrcImpl.clear()`", error: e);
    }
  }
}