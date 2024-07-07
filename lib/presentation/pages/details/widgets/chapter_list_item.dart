import 'package:flutter/material.dart';
import 'package:komikoo/domain/models/chapter/chapter.dart';
import 'package:komikoo/utils/formatter.dart';

class ChapterListItem extends StatelessWidget {
  final Chapter data;
  final void Function() onTap;

  const ChapterListItem({
    super.key,
    required this.data,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      onTap: onTap,
      leading: data.lang.flag,
      title: Text(
        data.getTitle(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        '${data.date?.toShortDateString()} • ${data.groups.join(', ')}',
        maxLines: 1,
        style: theme.textTheme.bodySmall!.copyWith(
          color: theme.textTheme.bodySmall!.color!.withOpacity(0.8),
        ),
      ),
    );
  }
}
