import 'package:common/arch/domain/model/education_data.dart';
import 'package:common/arch/domain/model/home_data.dart';
import 'package:common/arch/domain/usecase/mother_usecase.dart';
import 'package:core/domain/model/result.dart';
import 'package:core/ui/base/async_vm.dart';
import 'package:core/ui/base/live_data.dart';
import 'package:home/core/domain/usecase/home_page_use_case.dart';

class HomeVm extends AsyncVm {
  static const getStatusListKey = "getStatusList";
  static const getMenuListKey = "getMenuList";
  static const getTipsListKey = "getTipsList";

  HomeVm({
    required GetHomeStatusList getHomeStatusList,
    required GetHomeMenuList getHomeMenuList,
    required GetHomeTipsList getHomeTipsList,
    required GetMotherNik getMotherNik,
  }):
    _getHomeMenuList = getHomeMenuList,
    _getHomeStatusList = getHomeStatusList,
    _getHomeTipsList = getHomeTipsList,
    _getMotherNik = getMotherNik
  ;
  final GetMotherNik _getMotherNik;
  final GetHomeStatusList _getHomeStatusList;
  final GetHomeMenuList _getHomeMenuList;
  final GetHomeTipsList _getHomeTipsList;

  final MutableLiveData<List<HomeStatus>> _homeStatusList = MutableLiveData();
  final MutableLiveData<List<HomeMenu>> _homeMenuList = MutableLiveData();
  final MutableLiveData<List<Tips>> _homeTipsList = MutableLiveData();

  LiveData<List<HomeStatus>> get homeStatusList => _homeStatusList;
  LiveData<List<HomeMenu>> get homeMenuList => _homeMenuList;
  LiveData<List<Tips>> get homeTipsList => _homeTipsList;

  @override
  List<LiveData> get liveDatas => [_homeStatusList, _homeMenuList, _homeTipsList];

  void getStatusList([bool forceLoad = false]) {
    if(!forceLoad && _homeStatusList.value != null) return;
    startJob(getStatusListKey, (isActive) async {
      final res1 = await _getMotherNik();
      if(res1 is Success<String>) {
        final motherNik = res1.data;
        final res2 = await _getHomeStatusList(motherNik);
        if(res2 is Success<List<HomeStatus>>) {
          final data = res2.data;
          _homeStatusList.value = data;
          return null;
        }
        return res2 as Fail;
      }
      return res1 as Fail;
    });
  }
  void getMenuList([bool forceLoad = false]) {
    if(!forceLoad && _homeStatusList.value != null) return;
    startJob(getMenuListKey, (isActive) async {
      _getHomeMenuList().then((value) {
        if(value is Success<List<HomeMenu>>) {
          final data = value.data;
          _homeMenuList.value = data;
        }
      });
    });
  }
  void getTipsList([bool forceLoad = false]) {
    if(!forceLoad && _homeStatusList.value != null) return;
    startJob(getTipsListKey, (isActive) async {
      final res1 = await _getMotherNik();
      if(res1 is Success<String>) {
        final motherNik = res1.data;
        final res2 = await _getHomeTipsList(motherNik);
        if(res2 is Success<List<Tips>>) {
          final data = res2.data;
          _homeTipsList.value = data;
          return null;
        }
        return res2 as Fail;
      }
      return res1 as Fail;
    });
  }
}