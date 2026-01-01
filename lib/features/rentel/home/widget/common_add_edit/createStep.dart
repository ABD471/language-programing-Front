import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Step createStep({
  required int index,
  required String title,
  required Widget content,
  required dynamic controller,
  StepState? state,
  bool? isActive,
}) {
  return Step(
    isActive: isActive ?? (controller.currentStep.value >= index),
    state:
        state ??
        (controller.currentStep.value > index
            ? StepState.complete
            : (controller.currentStep.value == index
                  ? StepState.editing
                  : StepState.indexed)),
    title: Text(
      title,
      style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold),
    ),
    content: Container(
      padding: EdgeInsets.symmetric(vertical: 1.5.h),
      child: content,
    ),
  );
}
