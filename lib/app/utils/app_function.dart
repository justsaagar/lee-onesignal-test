import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:untitled/app/constant/color_constant.dart';
import 'package:untitled/app/constant/string_constant.dart';
import 'package:untitled/app/helper/extension_helper.dart';
import 'package:untitled/app/utils/dimension.dart';
import 'package:untitled/app/widgets/app_button.dart';
import 'package:untitled/app/widgets/app_text.dart';
import 'package:untitled/service/permission_service.dart';

mixin AppFunction {
  static Future<File?> selectImage() async {
    final source = await Get.dialog<ImageSource>(
      AlertDialog(
        backgroundColor: AppColorConstant.appWhite,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppText("Select option to upload."),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: AppButton(
                    title: 'Camera',
                    onTap: () => Get.back(result: ImageSource.camera),
                  ),
                ),
                const SizedBox(width: Dimens.widthNormal),
                Expanded(
                  child: AppButton(
                    title: 'Gallery',
                    onTap: () => Get.back(result: ImageSource.gallery),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    if (source != null) {
      if (source == ImageSource.gallery) {
        final permissionGranted = await PermissionService.instance
            .requestStorageOrMediaPermission();
        'permissionGranted --> $permissionGranted'.infoLogs();
        if (!permissionGranted) {
          return null;
        } else {
          final pickedFile = await ImagePicker().pickImage(source: source);
          if (pickedFile != null) {
            return File(pickedFile.path);
          }
        }
      }
      if (source == ImageSource.camera) {
        final permissionGranted = await PermissionService.instance
            .requestPermission(Permission.camera);
        if (!permissionGranted) return null;
        final pickedFile = await ImagePicker().pickImage(source: source);
        if (pickedFile != null) {
          return File(pickedFile.path);
        }
      }
    }
    return null;
  }

  static Future<void> showExitDialog() async {
    await Get.dialog<bool>(
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppText(
              StringConstant.exitAppDescription,
              fontSize: Dimens.size20,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Dimens.heightSmallMedium),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    title: StringConstant.cancel,
                    onTap: () => Get.back(),
                  ),
                ),
                const SizedBox(width: Dimens.heightSmall),
                Expanded(
                  child: AppButton(
                    title: StringConstant.yes,
                    onTap: () => SystemNavigator.pop(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Future<void> showPermissionDialog() async {
    await Get.dialog<bool>(
      barrierDismissible: false,
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppText(
              StringConstant.permissionDescription,
              fontSize: Dimens.size20,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Dimens.heightXSmall),
            const AppText(
              StringConstant.permissionSubDescription,
              fontSize: Dimens.size20,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Dimens.heightExtraMedium),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    title: StringConstant.notNow,
                    onTap: () => Get.back(),
                  ),
                ),
                const SizedBox(width: Dimens.heightSmall),
                Expanded(
                  child: AppButton(
                    title: StringConstant.goToSetting,
                    onTap: () async {
                      final bool isOpened = await openAppSettings();
                      if (isOpened) Get.back();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
