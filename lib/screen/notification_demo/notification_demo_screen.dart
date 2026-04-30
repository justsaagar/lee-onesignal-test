import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/app/constant/color_constant.dart';
import 'package:untitled/app/constant/string_constant.dart';
import 'package:untitled/app/utils/dimension.dart';
import 'package:untitled/app/widgets/app_button.dart';
import 'package:untitled/app/widgets/app_text.dart';
import 'package:untitled/app/widgets/app_text_form_field.dart';
import 'package:untitled/controller/notification_demo_controller.dart';

class NotificationDemoScreen extends StatelessWidget {
  const NotificationDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NotificationDemoController controller = Get.put(
      NotificationDemoController(),
    );

    return Scaffold(
      backgroundColor: AppColorConstant.appWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DimensPadding.paddingExtraSemiLarge,
          ),
          child: Column(
            children: [
              const SizedBox(height: Dimens.heightSmallMedium),
              const AppText(
                StringConstant.notificationDemoTitle,
                fontSize: Dimens.textSizeLarge,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: Dimens.heightTiny),
              Container(
                height: 2,
                width: 32,
                color: AppColorConstant.appLightPurple,
              ),
              const SizedBox(height: Dimens.heightExtraMedium),
              const Align(
                alignment: Alignment.centerLeft,
                child: AppText(
                  StringConstant.yourName,
                  fontSize: Dimens.textSizeSmall,
                  fontWeight: FontWeight.w500,
                  color: AppColorConstant.appDarkGrey,
                ),
              ),
              const SizedBox(height: Dimens.heightExtraSmall),
              AppTextFormField(
                controller: controller.nameController,
                hintText: StringConstant.enterYourName,
                onChanged: controller.onNameChanged,
                borderColor: AppColorConstant.appLightGrey,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: Dimens.heightNormal),
              AppButton(
                title: StringConstant.continueText,
                onTap: controller.onContinueTap,
                width: double.infinity,
                height: Dimens.heightSemiMedium,
                color: AppColorConstant.appLightPurple,
              ),
              const SizedBox(height: Dimens.heightExtraSmallMedium),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: DimensPadding.paddingExtraMedium,
                  horizontal: DimensPadding.paddingMedium,
                ),
                decoration: BoxDecoration(
                  color: AppColorConstant.appWhite200,
                  borderRadius: BorderRadius.circular(
                    Dimens.borderRadiusMedium,
                  ),
                  border: Border.all(color: AppColorConstant.appLightGrey),
                ),
                child: Column(
                  children: [
                    const AppText(
                      StringConstant.greetingLabel,
                      fontSize: Dimens.textSizeSmall,
                      fontWeight: FontWeight.w700,
                      color: AppColorConstant.appLightPurple,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: Dimens.heightExtraSmall),
                    Obx(
                      () => AppText(
                        '${StringConstant.helloPrefix}, ${controller.greetingName.value}',
                        fontSize: Dimens.textSizeLarge,
                        fontWeight: FontWeight.w700,
                        color: AppColorConstant.appExtraLightGrey,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Dimens.heightExtraNormal),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AppText(
                    StringConstant.dotBullet,
                    color: AppColorConstant.appExtraLightGrey,
                    fontSize: Dimens.textSizeSmall,
                  ),
                  SizedBox(width: Dimens.widthSmall),
                  AppText(
                    StringConstant.notificationInfo,
                    fontSize: Dimens.textSizeSmall,
                    fontWeight: FontWeight.w400,
                    color: AppColorConstant.appExtraLightGrey,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
