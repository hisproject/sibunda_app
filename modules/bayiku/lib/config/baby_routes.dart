import 'package:bayiku/di/baby_vm_di.dart';
import 'package:bayiku/ui/chart/baby_chart_page.dart';
import 'package:bayiku/ui/chart/baby_growth_chart_menu_page.dart';
import 'package:bayiku/ui/check_form/baby_check_form_page.dart';
import 'package:bayiku/ui/home/baby_home_page.dart';
import 'package:bayiku/ui/immunization/baby_immunization_page.dart';
import 'package:bayiku/ui/immunization/baby_immunization_popup_page.dart';
import 'package:bayiku/ui/neonatal_service/neonatal_service_page.dart';
import 'package:common/arch/domain/model/baby_data.dart';
import 'package:common/arch/domain/model/chart_data_baby.dart';
import 'package:common/arch/domain/model/immunization.dart';
import 'package:common/arch/ui/model/immunization_data.dart';
import 'package:common/arch/ui/page/_page.dart';
import 'package:common/arch/ui/widget/form_controller.dart';
import 'package:common/arch/ui/widget/form_faker.dart';
import 'package:common/config/_config.dart';
import 'package:common/util/providers.dart';
import 'package:common/util/navigations.dart' as nav_ext;
import 'package:common/value/const_values.dart';
import 'package:flutter/material.dart';

class BabyRoutes extends ModuleRoute {
  BabyRoutes._() : super(GlobalRoutes.manager);
  static final obj = BabyRoutes._();

  @override
  SibRoute get entryPoint => babyHomePage;

  @override
  String get name => GlobalRoutes.bayiku;

  @override
  Set<SibRoute> get routes => {
    babyHomePage,
    babyCheckPage._route,
    babyImmunizationPage._route,
    chartPageRoute._route,
  };

  static final babyHomePage = SibRoute("BabyHomePage", BabyHomePage, (ctx) => MainFrame(
    body: BabyHomePage().inVmProvider([
          (ctx) => BabyVmDi.babyHomeVm,
    ]),
  ));
  static final babyCheckPage = _BabyCheckFormPage.obj;
  static final neonatalServicePage = SibRoute("NeonatalServicePage", NeonatalServicePage, (ctx) {
    final FormGroupInterceptor? interceptor = FormGroupInterceptor();
    return MainFrame(
      body: FormFaker(
        interceptor: interceptor,
        child: NeonatalServicePage(interceptor: interceptor,).inVmProvider([
              (ctx) => BabyVmDi.neonatalServiceVm,
        ]),
      ),
    );
  });

  static final babyImmunizationPage = _BabyImmunizationPageRoute.obj;
  static final growthChartMenuVm = SibRoute("BabyGrowthChartMenuVm", BabyGrowthChartMenuPage, (ctx) => MainFrame(
    body: BabyGrowthChartMenuPage().inVmProvider([
          (ctx) => BabyVmDi.growthChartMenuVm,
    ]),
  ));
  static final chartPageRoute = _BabyChartPageRoute.obj;

  // ================= POPUP ================
  static final immunizationPopup = _BabyImmunizationPopupRoute.obj;
}


class _BabyCheckFormPage {
  _BabyCheckFormPage._();
  static final obj = _BabyCheckFormPage._();

  final SibRoute _route = SibRoute("BabyCheckFormPage", BabyCheckFormPage, (ctx) {
    final FormGroupInterceptor? interceptor = FormGroupInterceptor();
    return MainFrame(
      body: FormFaker(
        interceptor: interceptor,
        child: BabyCheckFormPage(interceptor: interceptor,).inVmProvider([
              (ctx) => BabyVmDi.babyCheckFormVm,
        ]),
      )
    );
  });

  void go(BuildContext context, BabyFormMenuData formData) {
    _route.goToPage(context, args: { Const.KEY_DATA: formData });
  }
}


class _BabyImmunizationPopupRoute {
  _BabyImmunizationPopupRoute._();
  static final obj = _BabyImmunizationPopupRoute._();
/*
  final SibRoute _route = SibRoute("BabyImmunizationPopup", BabyImmunizationPopupPage, (ctx) => MainFrame(
    body: BabyImmunizationPopupPage().inVmProvider([
          (ctx) => KehamilankuVmDi.immunizationVm,
    ]),
  ));
 */
  /// Returns future String. String is for date confirmation. If null, then
  /// it means the confirmation is not successful.
  Future<BabyImmunizationPopupResult?> popup(BuildContext context, ImmunizationData immunization) {
    //_route.goToPage(context, args: {Const.KEY_TRIMESTER : data});
    final _route = SibRoute("BabyImmunizationPopup", BabyImmunizationPopupPage, (ctx) => MainFrame(
      body: BabyImmunizationPopupPage().inVmProvider([
            (ctx) => BabyVmDi.immunizationPopupVm(immunization),
      ]),
    ));
    return _route.showAsDialog<BabyImmunizationPopupResult>(context);
  }
  void backPage(BuildContext context, BabyImmunizationPopupResult? date) {
    nav_ext.backPage(context, result: date);
  }
}

class _BabyChartPageRoute {
  _BabyChartPageRoute._();
  static final obj = _BabyChartPageRoute._();

  final _route = SibRoute("BabyChartPage", BabyChartPage, (ctx) => MainFrame(
    body: BabyChartPage().inVmProvider([
      (ctx) => BabyVmDi.chartVm,
    ]),
  ));

  void go(BuildContext context, BabyChartType type) {
    _route.goToPage(context, args: { Const.KEY_DATA: type });
  }
}

class _BabyImmunizationPageRoute {
  _BabyImmunizationPageRoute._();
  static final obj = _BabyImmunizationPageRoute._();

  final _route = SibRoute("BabyImmunizationPage", BabyImmunizationPage, (ctx) => MainFrame(
    body: BabyImmunizationPage().inVmProvider([
          (ctx) => BabyVmDi.babyImmunizationVm,
    ]),
  ));
  void go(BuildContext context, String babyNik) {
    _route.goToPage(context, args: { Const.KEY_DATA: babyNik });
  }
}