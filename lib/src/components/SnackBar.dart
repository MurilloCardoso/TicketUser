import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Snackbars {
  static void success(BuildContext context, String text) {
    showTopSnackBar(
        context,
        SizedBox(
          height: 56,
          child: CustomSnackBar.success(
            backgroundColor: Colors.green,
            icon: const Icon(
              Icons.close,
              color: Colors.white,
              size: 26,
            ),
            iconPositionLeft: 10,
            iconRotationAngle: 0,
            iconPositionTop: -20,
            messagePadding: const EdgeInsets.only(left: 40, right: 6),
            message: text,
          ),
        ),
        animationDuration: const Duration(milliseconds: 600),
        displayDuration: const Duration(minutes: 1), onTap: () {
      DismissType.onTap;
    });
  }

  static void error(BuildContext context, String text) {
    showTopSnackBar(
      context,
      SizedBox(
        height: 56,
        child: CustomSnackBar.error(
          icon: const Icon(
            Icons.close,
            color: Colors.white,
            size: 26,
          ),
          iconPositionLeft: 10,
          iconRotationAngle: 0,
          iconPositionTop: -20,
          messagePadding: const EdgeInsets.only(left: 40, right: 6),
          message: text,
        ),
      ),
      animationDuration: const Duration(milliseconds: 600),
      displayDuration: const Duration(minutes: 1),
      dismissType: DismissType.onTap,
    );
  }
}