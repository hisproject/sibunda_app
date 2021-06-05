import 'package:common/util/functions/nav_ext.dart' as NavExt;
import 'package:flutter/material.dart';

class SibRoute {
  final String name;
  final Type klass;
  final Widget Function(BuildContext) builder;
  const SibRoute(this.name, this.klass, this.builder);

  void goToPage(BuildContext context, {Map<String, dynamic>? args, bool clearPrevs = false, bool post = true}){
    if(post) {
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) =>
          NavExt.goToPage(context, builder, name: name, clearPrevs: clearPrevs));
    } else {
      NavExt.goToPage(context, builder, name: name, clearPrevs: clearPrevs);
    }
  }
}