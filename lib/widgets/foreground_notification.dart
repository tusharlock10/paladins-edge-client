import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:paladinsedge/theme/index.dart' as theme;
import 'package:paladinsedge/widgets/index.dart' as widgets;

void showForegroundNotification({
  required String title,
  required String body,
  required String imageUrl,
}) =>
    showSimpleNotification(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            body,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
      leading: widgets.ElevatedAvatar(
        size: 28,
        borderRadius: 5,
        imageUrl: imageUrl,
        elevation: 7,
      ),
      slideDismissDirection: DismissDirection.horizontal,
      duration: const Duration(seconds: 5),
      background: theme.themeMaterialColor.shade400,
      elevation: 7,
    );
