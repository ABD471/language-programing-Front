import 'package:apartment_rental_system/features/rentel/home/widget/common_add_edit/buildCustomControls.dart';
import 'package:flutter/material.dart';

Widget buildStepper({
  required BuildContext context,
  required dynamic controller,
  required List<Step> steps,
}) {
  final theme = Theme.of(context);

  return Theme(
    data: theme.copyWith(
      colorScheme: theme.colorScheme.copyWith(
        primary: theme.primaryColor,
        secondary: theme.primaryColor,
      ),

      canvasColor: Colors.transparent,
    ),
    child: Stepper(
      type: StepperType.horizontal,
      currentStep: controller.currentStep.value,
      elevation: 0,
      physics: const BouncingScrollPhysics(),

      onStepContinue: controller.nextStep,
      onStepCancel: controller.previousStep,

      controlsBuilder: (context, details) =>
          buildCustomControls(details, context, controller),
      steps: steps,
    ),
  );
}
