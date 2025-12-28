import 'package:flutter/material.dart';

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
      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
    ),

    content: Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: content,
    ),
  );
}
