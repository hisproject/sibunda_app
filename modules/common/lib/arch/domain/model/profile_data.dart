import 'package:common/arch/data/local/db/app_db.dart';
import 'package:common/arch/data/remote/model/data_api_model.dart';
import 'package:common/arch/domain/model/img_data.dart';
import 'package:common/util/type_util.dart';
import 'package:common/value/const_values.dart';
import 'package:common/value/db_const.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_data.freezed.dart';
part 'profile_data.g.dart';


class Profile {
  final String name;
  final String email;
  final ImgData img;

  Profile({
    required this.name,
    required this.email,
    required this.img,
  });
}


class AccountData {
  final String name;
  final String email;
  final String pswd;
  final ImgData img;

  AccountData({
    required this.name,
    required this.email,
    required this.pswd,
    required this.img,
  });
}

/// This is just like [BatchProfileServer], but only their ids.
@freezed
class BatchProfileIds with _$BatchProfileIds {
  const factory BatchProfileIds({
    required int motherId,
    required int fatherId,
    required List<int> childrenId,
  }) = _BatchProfileIds;
  factory BatchProfileIds.fromJson(Map<String, dynamic> map) = _BatchProfileIds.fromJson;
  factory BatchProfileIds.fromResponse(BioMotherResponse response) => BatchProfileIds(
    motherId: response.id,
    fatherId: response.kia_ayah.id,
    childrenId: response.kia_anak.map<int>((e) => e.id).toList(growable: false),
  );
}

@freezed
class BatchProfileServer with _$BatchProfileServer {
  const factory BatchProfileServer({
    required ProfileEntity mother,
    required ProfileEntity father,
    required List<ProfileEntity> children,
  }) = _BatchProfileServer;
  factory BatchProfileServer.fromJson(Map<String, dynamic> map) = _BatchProfileServer.fromJson;
  factory BatchProfileServer.fromBioResponse(BioMotherResponse response) {
    final userId = response.user_id;
    final mother = ProfileEntity(
      userId: userId,
      type: DbConst.TYPE_MOTHER,
      serverId: response.id,
      name: response.nama,
      nik: response.nik,
      birthDate: parseDate(response.tanggal_lahir),
      birthPlace: response.tempat_lahir,
    );
    final rawFather = response.kia_ayah;
    final father = ProfileEntity(
      userId: userId,
      type: DbConst.TYPE_FATHER,
      serverId: rawFather.id,
      name: rawFather.nama,
      nik: rawFather.nik,
      birthDate: parseDate(rawFather.tanggal_lahir),
      birthPlace: rawFather.tempat_lahir,
    );
    final children = response.kia_anak.map<ProfileEntity>((e) => ProfileEntity(
      userId: userId,
      type: DbConst.TYPE_CHILD,
      serverId: e.id,
      name: e.nama,
      nik: e.nik,
      birthDate: parseDate(e.tanggal_lahir),
      birthPlace: e.tempat_lahir,
    )).toList(growable: false);

    return BatchProfileServer(mother: mother, father: father, children: children);
  }
}