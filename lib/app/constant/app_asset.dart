import 'package:google_fonts/google_fonts.dart';

mixin AppAsset {
  static String? defaultFont = GoogleFonts.lato().fontFamily;
  static const String imagePath = 'assets/images/';
  static const String iconPath = 'assets/icons/';
  static const String jsonPath = 'assets/json/';
  static const String animationPath = 'assets/animations/';

  //******************************** Image ********************************
  static const String appBackground = '${imagePath}app_background.png';
  static const String appIcon = '${imagePath}app_icon.png';
}
