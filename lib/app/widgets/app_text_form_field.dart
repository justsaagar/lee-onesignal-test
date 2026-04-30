import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/app/constant/color_constant.dart';
import 'package:untitled/app/utils/dimension.dart';
import 'package:untitled/app/widgets/app_image_assets.dart';
import 'package:untitled/app/widgets/app_text.dart';

class AppTextFormField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Function(String)? onChanged;
  final bool obscureText;
  final VoidCallback? onSuffixPressed;
  final String? errorText;
  final String? initialValue;
  final String? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final Color? borderColor;
  final bool? enableInteractiveSelection;
  final bool? isMaxLines;
  final TextInputAction? textInputAction;

  const AppTextFormField({
    super.key,
    this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.obscureText = false,
    this.onSuffixPressed,
    this.borderColor,
    this.enableInteractiveSelection,
    this.errorText,
    this.initialValue,
    this.inputFormatters,
    this.suffixIcon,
    this.isMaxLines = false,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColorConstant.appWhite,
            borderRadius: BorderRadius.circular(Dimens.borderRadiusMedium),
            border: Border.all(
              color: borderColor ?? AppColorConstant.appTransparent,
              width: 2,
            ),
          ),
          child: TextFormField(
            controller: controller,
            initialValue: initialValue,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            onChanged: onChanged,
            obscureText: obscureText,
            textInputAction: textInputAction ?? TextInputAction.done,
            maxLines: isMaxLines == true ? null : 1,
            selectionControls: enableInteractiveSelection == false
                ? DesktopTextSelectionControls()
                : MaterialTextSelectionControls(),
            decoration: InputDecoration(
              hintText: hintText?.toLowerCase(),
              hintMaxLines: 1,
              hintStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColorConstant.appGrey,
              ),
              contentPadding: const EdgeInsets.all(DimensPadding.paddingMedium),
              border: InputBorder.none,
              suffixIcon: onSuffixPressed != null
                  ? IconButton(
                      onPressed: onSuffixPressed,
                      icon: suffixIcon != null
                          ? AppImageAsset(
                              image: suffixIcon!,
                              color: AppColorConstant.appGrey,
                              height: Dimens.heightSmallMedium,
                            )
                          : Icon(
                              obscureText
                                  ? Icons.visibility_rounded
                                  : Icons.visibility_off_rounded,
                              color: AppColorConstant.appGrey,
                            ),
                    )
                  : null,
            ),
          ),
        ),
        if (errorText != null && (errorText?.isNotEmpty == true))
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: AppText(
              errorText ?? '',
              color: AppColorConstant.appWhite,
              fontSize: 12,
            ),
          ),
      ],
    );
  }
}
