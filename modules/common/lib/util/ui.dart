
import 'package:common/arch/domain/model/_model_template.dart';
import 'package:common/arch/ui/widget/popup_widget.dart';
import 'package:common/res/theme/_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension SnackBarExt on SnackBar {
  void show(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(this);
  }
}

void showSnackBar(
  BuildContext context, String text, {
  Color? backgroundColor,
  Duration? duration,
  bool post = true,
}) {
  if(post) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) =>
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: duration ?? Duration(milliseconds: 1500),
            backgroundColor: backgroundColor ?? Theme.of(context).errorColor,
            content: Text(text),
          )
      )
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: duration ?? Duration(milliseconds: 1500),
          backgroundColor: backgroundColor ?? Theme.of(context).errorColor,
          content: Text(text),
        )
    );
  }
}

void showIdStringPopup({
  required BuildContext context,
  required List<IdStringModel> dataList,
  void Function(int id, String name)? onItemClick,
  bool autoDismiss = true,
  String? title,
}) {
  final titleWidget = title != null ? Text(
    title,
    style: SibTextStyles.size_0_bold,
  ) : null;

  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: titleWidget,
      content: IdStringPopup(
        dataList: dataList,
        onItemClick: (i, name) {
          if(autoDismiss) {
            Navigator.pop(context);
          }
          onItemClick?.call(i, name);
        },
      ),
    ),
  );
}

extension SizeFactor on num {
  double dp(BuildContext context) => this * MediaQuery.of(context).devicePixelRatio;
  double sp(BuildContext context) => this * MediaQuery.of(context).textScaleFactor;
}

extension WidgetExt on Widget {
  Widget withMargin(EdgeInsetsGeometry margin) => Container(
    child: this,
    margin: margin,
  );
  Padding withPadding(EdgeInsetsGeometry padding) => Padding(
    child: this,
    padding: padding,
  );
  Widget insideScroll() => SingleChildScrollView(
    child: this,
  );
/*
  Widget relativeConstraint({
    double top = 0,
    double bottom = double.infinity,
    double left = 0,
    double right = double.infinity,
    double verticalBias = -1,
    double horizontalBias = -1,
  }) {

  }
 */
}


extension GlobalKeyExt on GlobalKey {
  Rect? get globalPaintBounds {
    final renderObject = currentContext?.findRenderObject();
    var translation = renderObject?.getTransformTo(null).getTranslation();
    if (translation != null && renderObject?.paintBounds != null) {
      return renderObject!.paintBounds
          .shift(Offset(translation.x, translation.y));
    } else {
      return null;
    }
  }
}

/*
void afaf(){
  final a = GlobalKey();
  final b = a.globalPaintBounds;

}


 */

void visitNestedChildren(BuildContext context, void Function(Element) visitor) {
  context.visitChildElements((child) {
    visitor(child);
    visitNestedChildren(child, visitor);
  });
}