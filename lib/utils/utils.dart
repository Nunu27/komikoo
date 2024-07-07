import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:komikoo/constants/height_constants.dart';

Future<bool> showConfirmationDialog({
  required BuildContext context,
  required String title,
  required String content,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 7),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 7),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () {
              context.maybePop(false);
            },
          ),
          TextButton(
            child: const Text("Continue"),
            onPressed: () {
              context.maybePop(true);
            },
          ),
        ],
      );
    },
  );

  return result ?? false;
}

double getTextHeight(TextStyle style) {
  return style.fontSize! * style.height!;
}

Size getCardSize(MediaQueryData mediaQuery, ThemeData theme) {
  final cardWidth = (mediaQuery.size.width - 21) / 3;
  final cardTextHeight = getTextHeight(theme.textTheme.titleSmall!) * 2;

  return Size(
    cardWidth,
    cardWidth / HeightConstants.coverRatio + 17 + cardTextHeight,
  );
}
