import 'package:flutter/material.dart';
import 'package:untitled/app/constant/app_asset.dart';
import 'package:untitled/app/widgets/app_image_assets.dart';

class AppBackground extends StatelessWidget {
  final Widget child;

  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppImageAsset(
          image: AppAsset.appBackground,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        SafeArea(child: child),
      ],
    );
  }
}
