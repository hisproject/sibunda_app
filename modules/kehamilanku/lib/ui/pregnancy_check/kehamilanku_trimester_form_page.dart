
import 'package:common/arch/domain/model/form_warning_status.dart';
import 'package:common/arch/domain/model/kehamilanku_data.dart';
import 'package:common/arch/ui/adapter/form_warning_adp.dart';
import 'package:common/arch/ui/adapter/top_bar_item_list_adp.dart';
import 'package:common/arch/ui/page/secondary_frames.dart';
import 'package:common/arch/ui/widget/_basic_widget.dart';
import 'package:common/arch/ui/widget/_items_kehamilanku.dart';
import 'package:common/arch/ui/widget/form_controller.dart';
import 'package:common/arch/ui/widget/form_faker.dart';
import 'package:common/arch/ui/widget/form_generic_vm_group_observer.dart';
import 'package:common/arch/ui/widget/picker_icon_widget.dart';
import 'package:common/arch/ui/widget/popup_widget.dart';
import 'package:common/config/routes.dart';
import 'package:common/res/string/_string.dart';
import 'package:common/res/theme/_theme.dart';
import 'package:common/util/navigations.dart';
import 'package:common/util/ui.dart';
import 'package:common/value/const_values.dart';
import 'package:core/ui/base/async_view_model_observer.dart';
import 'package:core/ui/base/live_data_observer.dart';
import 'package:core/ui/base/view_model.dart';
import 'package:core/util/_consoles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kehamilanku/config/kehamilanku_routes.dart';
import 'package:kehamilanku/ui/pregnancy_check/kehamilanku_trimester_form_vm.dart';

class KehamilankuTrimesterFormPage extends StatelessWidget {
  //final scrollCtrl = ScrollController();
  final pageController = PageController();
  final FormGroupInterceptor? interceptor;

  KehamilankuTrimesterFormPage({
    this.interceptor,
  });

  @override
  Widget build(BuildContext context) {
    final isLastTrimester = getArgs<bool>(context, Const.KEY_IS_LAST_TRIMESTER) == true;

    final trimester = getArgs<MotherTrimester>(context, Const.KEY_TRIMESTER)!;
    final startWeek = trimester.startWeek;
    final weekCount = trimester.endWeek - startWeek +1;
    final vm = ViewModelProvider.of<KehamilankuCheckFormVm>(context)
      ..initVm();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      await Future.delayed(Duration(milliseconds: 500));
      pageController.jumpToPage(0);
      pageController.notifyListeners();
    });

    //vm.currentWeek.value = startWeek;
    //vm.initPage(week: startWeek);
    vm.currentTrimesterId = trimester.id;

    pageController.addListener(() {
      final page = pageController.page;
      //prind("pageController page= $page double = ${pageController.page}");
      if(page != null) {
        //prind("pageController MASUK ===========");
        int pageInt;
        if(page == (pageInt = page.toInt())) {
          final week = pageInt +startWeek;
          prind("pageController MASUK =========== INT page= $page week = $week");
          vm.initPage(week: week);
/*
          vm..currentWeek.value = week
            ..getPregnancyCheck(week: week, forceLoad: true)
            ..getPregnancyBabySize(week: week, forceLoad: true)
            ..getMotherFormWarningStatus(week: week, forceLoad: true);
 */
        }
      }
    });

    final weekList = List.generate(weekCount, (index) => "Minggu ${index + startWeek}");

    return TopBarTitleAndBackFrame(
      withTopOffset: true,
      title: "Trimester ${trimester.trimester}",

      topBarChild: SizedBox(
        height: 50,
        child: TopBarItemCenterAlignList(
          dataList: weekList,
          pageController: pageController,
          //onItemClick: (i) => showSnackBar(context, "Dipencet i = $i"),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: PageView(
          controller: pageController,
          children: List.generate(weekCount, (index) => _WeeklyFormPage(
            vm: vm,
            interceptor: interceptor,
            week: index +startWeek,
            isLastTrimester: isLastTrimester,
          )),
        ),
      ),
    );
  }
}


class _WeeklyFormPage extends StatelessWidget {
  final int week;
  final bool isLastTrimester;
  final KehamilankuCheckFormVm vm;
  final FormGroupInterceptor? interceptor;
  final scrollControl = ScrollController();

  _WeeklyFormPage({
    required this.week,
    required this.isLastTrimester,
    required this.vm,
    this.interceptor,
  });

  @override
  Widget build(BuildContext context) {

    return BelowTopBarScrollContentArea(
      controller: scrollControl,
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate.fixed([
            MultiLiveDataObserver<dynamic>(
              liveDataList: [vm.currentWeek, vm.isBabyBorn],
              builder: (ctx, dataList) {
                final int? currentWeek = dataList[0];
                if(currentWeek != week) return defaultLoading();
                final bool? isBorn = dataList[1];

                final babySize = MultiLiveDataObserver<dynamic>(
                  liveDataList: [vm.pregnancyBabySize, vm.isBabySizeInit],
                  //distinctUntilChanged: false,
                  predicate: (data) => currentWeek == week,
                  //initBuilder: (ctx) => defaultLoading(),
                  //immediatelyBuildState: currentWeek == week && vm.isBabySizeInit.value == true,
                  builder: (ctx, dataList2) {
                    //if(currentWeek != wee)
                    final bool? isBabySizeInit = dataList2[1];
                    final PregnancyBabySize? babySize = dataList2[0];
                    prind("LiveDataObserver<PregnancyBabySize> dataList2= $dataList2 dataList= $dataList week = $week");
                    if(babySize == null) {
                      if(isBabySizeInit == true) return defaultEmptyWidget();
                      return defaultLoading();
                    }
                    return ItemMotherBabySizeOverview.fromData(babySize);
                  },
                );

                /*
                LiveDataObserver<List<FormWarningStatus>>(
                  liveData: vm.formWarningStatusList,
                  predicate: (data) => vm.currentWeek.value == week,
                  initBuilder: (ctx) => defaultLoading(),
                  immediatelyBuildState: vm.currentWeek.value == week,
                  builder: (ctx, data) =>
                );
                 */
                final analysis = LiveDataObserver<List<FormWarningStatus>>(
                  liveData: vm.formWarningStatusList,
                  predicate: (data) => vm.currentWeek.value == week,
                  initBuilder: (ctx) => defaultLoading(),
                  immediatelyBuildState: vm.currentWeek.value == week,
                  builder: (ctx, data) {
                    prind("TrimesterFormPage FormWarningList builder data= $data");
                    if(data == null) return defaultLoading();
                    if(data.isEmpty) return defaultEmptyWidget();
                    return Column(
                      children: [
                        //Container(margin: EdgeInsets.only(top: 20, bottom: 5,),),
                        SizedBox(height: 20,),
                        Text(
                          "Informasi Hasil Pemeriksaan",
                          style: SibTextStyles.size_0_bold,
                        ),
                        SizedBox(height: 5,),
                        FormWarningList(data),
                        TxtBtn(
                          "Lihat Grafik Evaluasi Kehamilan",
                          onTap: () => KehamilankuRoutes.pregEvalChartMenuPage.go(
                            context: context,
                            pregnancyCred: vm.pregnancyId,
                          ),
                        ),
                      ],
                    );
                  },
                );

                final children = <Widget>[
                  babySize, analysis,
                ];

                if(isLastTrimester && isBorn != true) {
                  children.insert(1, Padding(
                    padding: EdgeInsets.only(top: 10,),
                    child: TxtBtn(
                      "Konfirmasi Kelahiran Bayi",
                      onTap: () async {
                        final isSaved = await KehamilankuRoutes.obj.goToExternalRouteBuilder(
                          context,
                          GlobalRoutes.home_childFormPage,
                          builderArgs: GlobalRoutes.makeHomeChildFormPageData(),
                        );
                        if(isSaved == true) {
                          KehamilankuRoutes.obj.goToModule(
                            context,
                            GlobalRoutes.bayiku,
                            args: { Const.KEY_LOAD_LAST: true },
                            replaceCurrent: true,
                          );
                        }
                      },
                    ),
                  ),);
                }
                return Column(
                  children: children,
                );
              },
            ),
            FormVmGroupObserver<KehamilankuCheckFormVm>(
              vm: vm,
              interceptor: interceptor,
              predicate: () {
                //prind("_WeeklyFormPage FormVmGroupObserver<KehamilankuCheckFormVm>.predicate() week = $week vm.currentWeek.value = ${vm.currentWeek.value}");
                return vm.currentWeek.value == week;
                //|| vm.currentWeek.value == week;
                //|| vm.currentWeek.value == week -1
                //|| vm.currentWeek.value == week +1;
              },
              onPreSubmit: (ctx, canProceed) => canProceed == true
                  ? showSnackBar(ctx, "Submitting", backgroundColor: Colors.green)
                  : showSnackBar(ctx, "There still invalid fields"),
              onSubmit: (ctx, success) async {
                if(success) {
                  final res = await showDialog<bool>(context: context, builder: (ctx) => AlertDialog(
                    content: PopupSuccess(
                      msg: "Data Pemeriksaan Bunda berhasil disimpan",
                      actionMsg: "Lihat hasil pemeriksaan",
                      onActionClick: () => Navigator.pop(context, true), //() => backPage(context, backStep: 2),
                    ),
                  )); //showSnackBar(ctx, "Berhasil bro", backgroundColor: Colors.green)
                  if(res == true) {
                    vm.getMotherFormWarningStatus(week: week, forceLoad: true,);
                    vm.getPregnancyBabySize(week: week, forceLoad: true,);
                    scrollControl.animateTo( 0,
                      duration: Duration(seconds: 1),
                      curve: Curves.easeOut,
                    );
                  }
                } else {
                  showSnackBar(ctx, Strings.form_submission_fail);
                }
              },
              pickerIconBuilder: (group, key, data) {
                switch(key) {
                  case Const.KEY_BABY_GENDER:
                    return GenderPickerIcon(
                      onItemSelected: (gender) async {
                        data.value = gender?.name[0];
                      },
                    );
                }
              },
              submitBtnBuilder: (ctx, canProceed) => Container(
                margin: EdgeInsets.only(bottom: 20),
                child: TxtBtn(
                  Strings.submit_check_form,
                  color: canProceed == true ? pink_300 : grey,
                ),
              ),
            ),
          ]),
        ),
      ],
    );
  }
}