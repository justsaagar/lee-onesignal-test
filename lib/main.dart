import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:untitled/app/config/app_config.dart';
import 'package:untitled/app/constant/color_constant.dart';
import 'package:untitled/app/di/injector.dart';
import 'package:untitled/app/helper/extension_helper.dart';
import 'package:untitled/app/routes/route_constant.dart';
import 'package:untitled/app/widgets/app_text.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AppInjector.registerAll();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          children: [
            GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: GetMaterialApp(
                title: 'CC Event Management',
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: Colors.deepPurple,
                  ),
                  useMaterial3: true,
                ),
                debugShowCheckedModeBanner: false,
                locale: Get.deviceLocale,
                initialRoute: RouteConstant.initial,
                getPages: GetPageRouteHelper.routes,
                defaultTransition: Transition.fadeIn,
                builder: (context, child) {
                  return MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(textScaler: TextScaler.noScaling),
                    child: child ?? const SizedBox(),
                  );
                },
              ),
            ),
            if (AppConfig.showFeedbackStrip)
              InkWell(
                onTap: () =>
                    AppConfig.feedbackEmail.launchStoreRating(),
                child: Container(
                  height: 120,
                  width: 30,
                  decoration: const BoxDecoration(
                    color: AppColorConstant.appBlack,
                  ),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 3),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RotatedBox(
                            quarterTurns: -1,
                            child: AppText(
                              'Feedback',
                              color: AppColorConstant.appWhite,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
