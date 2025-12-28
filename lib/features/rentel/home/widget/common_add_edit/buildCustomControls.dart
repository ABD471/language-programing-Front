import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildCustomControls(details, context, dynamic controller) {
  final theme = Theme.of(context);

  String getFinalStepText() {
    if (controller.currentStep.value == 2) {
      return controller.runtimeType.toString() == "EditApartmentController"
          ? "update".tr
          : "submit".tr;
    }
    return "next".tr;
  }

  return Container(
    margin: const EdgeInsets.only(top: 40, bottom: 10),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            height: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: [theme.primaryColor, theme.primaryColor.withAlpha(200)],
              ),
              boxShadow: [
                BoxShadow(
                  color: theme.primaryColor.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: details.onStepContinue,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                getFinalStepText(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ),

        if (controller.currentStep.value > 0) ...[
          const SizedBox(width: 16),
          Expanded(
            child: SizedBox(
              height: 55,
              child: OutlinedButton(
                onPressed: details.onStepCancel,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: theme.primaryColor.withOpacity(0.3),
                    width: 1.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  "previous".tr,
                  style: TextStyle(
                    color: theme.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    ),
  );
}
