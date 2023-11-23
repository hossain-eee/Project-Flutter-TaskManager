import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:module_11_class_3/ui/utils/assets.utils.dart';

class ScreenBackground extends StatelessWidget {
  final Widget
      child; //any variable name but inside widget parameter name is child/children

  const ScreenBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      //last widget will display on top of the stack, and first widget will display last of the stact
      children: [
        //this background inside SizedBox() widget will display last of the stack, that mean every widget will top of the background
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SvgPicture.asset(
            AssetsUtils.backgroundSvg, //

            fit: BoxFit.cover,
          ),
        ),
        //apply child variable(widget type) which will make widget tree inside the SafeArea() widget on top of the SizedBox() widget which contain background image
        // SafeArea(child: child),
         child,
      ],
    );
  }
}
