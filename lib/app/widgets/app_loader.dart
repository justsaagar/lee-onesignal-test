import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:untitled/app/constant/color_constant.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColorConstant.appPurple.withValues(alpha: 0.3),
      ),
      child: const Center(
        child: SpinKitSpinningLines(color: AppColorConstant.appLightPurple),
      ),
    );
  }
}
