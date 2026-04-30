import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/scheduler.dart';
import 'package:untitled/app/di/injector.dart';
import 'package:untitled/app/helper/extension_helper.dart';
import 'package:untitled/repository/utils/utils_repository.dart';
import 'package:untitled/screen/onboarding/onboarding_screen.dart';
import 'package:untitled/serialized/onboarding_model.dart';

class OnBoardingScreenHelper {
  OnBoardingScreenHelper(this.state) {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await getOnboardingData();
      updateState();
    });
  }

  final OnboardingScreenState state;

  final List<OnBoardingModel> onboardingData = [];
  final CarouselSliderController carouselController = CarouselSliderController();
  int currentPage = 0;

  void updateState() => state.onboardingController?.update();

  void manageCurrentPage(int value) {
    currentPage = value;
    updateState();
  }

  Future<void> getOnboardingData() async {
    final UtilsRepository utilsRepository = AppInjector.get<UtilsRepository>();
    final Map<String, dynamic>? data =
        await utilsRepository.getUtilsData('onboarding');
    if (data != null && data.containsKey('onSliders')) {
      'utilsData --> $data'.logs();
      onboardingData.clear();
      onboardingData.addAll(
        (data['onSliders'] as List)
            .map((e) => OnBoardingModel.fromJson(e as Map<String, dynamic>)),
      );
    }
  }
}
