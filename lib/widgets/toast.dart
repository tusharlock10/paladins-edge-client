import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

enum ToastType {
  success,
  error,
}

// ignore: long-method
void showToast({
  required BuildContext context,
  required String text,
  required ToastType type,
}) {
  showFlash(
    context: context,
    duration: const Duration(seconds: 5),
    builder: (context, controller) {
      final textTheme = Theme.of(context).textTheme;

      final toastColor = type == ToastType.success
          ? Colors.green.shade400
          : Colors.red.shade400;

      return Flash.bar(
        boxShadows: [
          BoxShadow(
            color: toastColor.withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(-1, 5),
          ),
        ],
        enableVerticalDrag: true,
        position: FlashPosition.bottom,
        margin: const EdgeInsets.only(bottom: 15),
        controller: controller,
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        child: Card(
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.all(0),
          child: IntrinsicWidth(
            child: Row(
              children: [
                Container(
                  height: 60,
                  width: 8,
                  color: toastColor,
                ),
                const SizedBox(width: 12),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    border: Border.all(width: 2, color: toastColor),
                  ),
                  height: 24,
                  width: 24,
                  child: type == ToastType.success
                      ? Icon(
                          Icons.check,
                          size: 18,
                          color: toastColor,
                        )
                      : Icon(
                          Icons.clear,
                          size: 18,
                          color: toastColor,
                        ),
                ),
                const SizedBox(width: 12),
                IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        type == ToastType.success ? 'Success' : 'Error',
                        style: textTheme.bodyText2?.copyWith(fontSize: 18),
                      ),
                      Text(
                        text,
                        style: textTheme.bodyText1?.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
              ],
            ),
          ),
        ),
      );
    },
  );
}
