import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:komikoo/domain/models/feed/list_item.dart';
import 'package:komikoo/router/app_router.gr.dart';
import 'package:komikoo/utils/utils.dart';
import 'package:komikoo/presentation/pages/feed/widgets/list_card.dart';

class ListFeedView extends StatelessWidget {
  final String title;
  final List<ListItem> items;
  final Map<String, dynamic>? more;

  const ListFeedView({
    super.key,
    required this.title,
    required this.items,
    required this.more,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final cardSize = getCardSize(mediaQuery, theme);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Text(
                title,
                style: theme.textTheme.titleLarge,
              ),
            ),
            if (more != null)
              IconButton(
                onPressed: () {
                  context.pushRoute(ExploreRoute(title: title, options: more!));
                },
                icon: const Icon(Icons.chevron_right),
              )
          ],
        ),
        SizedBox(
          height: cardSize.height,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(10.5).copyWith(top: 0),
            itemCount: items.length,
            itemBuilder: (context, index) => ListCard(
              data: items[index],
              width: cardSize.width,
            ),
          ),
        )
      ],
    );
  }
}
