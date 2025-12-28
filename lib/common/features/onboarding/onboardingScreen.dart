import 'package:apartment_rental_system/common/widget/gradientbackground.dart';
import 'package:apartment_rental_system/common/features/onboarding/controller/onBoardinController.dart';
import 'package:apartment_rental_system/common/features/onboarding/widget/AnimatedOnboardingItem.dart';
import 'package:apartment_rental_system/helper/const/onboardingList.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  final OnboardingController onboardingController = Get.put(
    OnboardingController(),
  );

  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // ---------------- Skip Button ----------------
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: onboardingController.finishOnboarding,
                    child: Text(
                      'skip'.tr,
                      style: theme.textTheme.headlineLarge?.copyWith(
                        color: colors.onPrimary,
                      ),
                    ),
                  ),
                ),

                // ---------------- Pages ----------------
                Expanded(
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: onboardingData.length,
                    onPageChanged: (index) {
                      setState(() {
                        isLastPage = index == onboardingData.length - 1;
                      });
                    },
                    itemBuilder: (context, index) {
                      final item = onboardingData[index];
                      return AnimatedOnboardingItem(
                        image: item.image,
                        title: item.title,
                        description: item.description,
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // ---------------- Indicator ----------------
                SmoothPageIndicator(
                  controller: _controller,
                  count: onboardingData.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: colors.secondary,
                    dotColor: colors.onPrimary.withOpacity(0.5),
                    dotHeight: 8,
                    dotWidth: 8,
                  ),
                ),

                const SizedBox(height: 32),

                // ---------------- Action Button ----------------
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (isLastPage) {
                        onboardingController.finishOnboarding();
                      } else {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Text(
                      isLastPage ? 'start_now'.tr : 'next'.tr,
                      style: theme.textTheme.labelLarge,
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
