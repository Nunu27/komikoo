import 'package:flutter/material.dart';
import 'package:komikoo/domain/models/chapter/chapter.dart';

class ChapterListItemCompact extends StatelessWidget {
  final bool isActive;
  final Chapter chapter;
  final void Function(int index) onTap;

  const ChapterListItemCompact({
    super.key,
    required this.isActive,
    required this.chapter,
    required this.onTap,
  });

  void handleTap() {
    onTap(chapter.index);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      shape: Border(
        top: BorderSide(color: theme.colorScheme.outlineVariant, width: 0.5),
        left: isActive
            ? BorderSide(color: theme.colorScheme.primary, width: 5)
            : BorderSide.none,
      ),
      onTap: handleTap,
      title: Text(
        chapter.getSimpleTitle(),
        maxLines: 1,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: isActive ? theme.colorScheme.primary : null,
        ),
      ),
    );
  }
}
