import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:komikoo/domain/controllers/history_controller.dart';
import 'package:komikoo/presentation/pages/feed/widgets/reading_card.dart';
import 'package:komikoo/router/app_router.gr.dart';
import 'package:komikoo/utils/utils.dart';

class ReadingFeedView extends ConsumerWidget {
  const ReadingFeedView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final cardSize = getCardSize(mediaQuery, theme);

    return ref.watch(historyListProvider(limit: 5, completed: false)).when(
          data: (history) => history.isEmpty
              ? const SizedBox()
              : Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 12),
                          child: Text(
                            'Continue reading',
                            style: theme.textTheme.titleLarge,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            context.navigateTo(const HistoryRoute());
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
                        itemCount: history.length,
                        itemBuilder: (context, index) => ReadingCard(
                          data: history[index],
                          width: cardSize.width,
                        ),
                      ),
                    )
                  ],
                ),
          error: (error, stackTrace) => const SizedBox(),
          loading: () => const SizedBox(),
        );
  }
}
