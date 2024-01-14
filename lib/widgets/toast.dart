import "package:flash/flash.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:paladinsedge/utilities/index.dart" as utilities;

enum ToastType {
  success,
  error,
  info,
}

class _FlashBar extends HookWidget {
  final FlashController<Object> controller;
  final ToastType type;
  final String text;
  final int? errorCode;

  const _FlashBar({
    required this.controller,
    required this.type,
    required this.text,
    this.errorCode,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final textTheme = Theme.of(context).textTheme;

    // Effects
    useEffect(
      () {
        utilities.Global.isToastShown = true;

        return () => utilities.Global.isToastShown = false;
      },
      [],
    );

    // Methods
    final getToastColor = useCallback(
      () {
        if (type == ToastType.success) return Colors.green.shade400;
        if (type == ToastType.info) return Colors.blue.shade200;

        return Colors.red.shade400;
      },
      [type],
    );

    final getToastMessage = useCallback(
      () {
        if (type == ToastType.success) return "Success";
        if (type == ToastType.info) return "Info";

        return errorCode == null ? "Error" : "Error ($errorCode)";
      },
      [type, errorCode],
    );

    final getToastIcon = useCallback(
      () {
        if (type == ToastType.success) return Icons.check;
        if (type == ToastType.info) return Icons.info_outline;

        return Icons.clear;
      },
      [type],
    );

    return FlashBar(
      controller: controller,
      position: FlashPosition.top,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Card(
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.all(0),
        child: SizedBox(
          height: 60,
          child: Row(
            children: [
              Container(
                width: 8,
                color: getToastColor(),
              ),
              const SizedBox(width: 12),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  border: type != ToastType.info
                      ? Border.all(width: 2, color: getToastColor())
                      : null,
                ),
                height: 24,
                width: 24,
                child: Icon(
                  getToastIcon(),
                  size: type != ToastType.info ? 18 : 24,
                  color: getToastColor(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      getToastMessage(),
                      style: textTheme.bodyMedium?.copyWith(fontSize: 18),
                    ),
                    Text(
                      text,
                      maxLines: 1,
                      style: textTheme.bodyLarge?.copyWith(
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
                      ),
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
  }
}

void showToast({
  required BuildContext context,
  required String text,
  required ToastType type,
  int? errorCode,
}) {
  if (utilities.Global.isToastShown) return;
  showFlash<Object>(
    context: context,
    duration: const Duration(seconds: 5),
    builder: (context, controller) => _FlashBar(
      controller: controller,
      type: type,
      text: text,
      errorCode: errorCode,
    ),
  );
}
