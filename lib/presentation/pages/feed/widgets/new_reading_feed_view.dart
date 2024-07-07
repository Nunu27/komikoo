import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:komikoo/domain/controllers/history_controller.dart';
import 'package:komikoo/presentation/pages/feed/widgets/new_reading_card.dart';
import 'package:komikoo/router/app_router.gr.dart';

class NewReadingView extends ConsumerWidget {
  const NewReadingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return ref.watch(historyListProvider(limit: 5, completed: false)).when(
        data: (history) => Column(
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
                CarouselSlider.builder(
                  itemCount: history.length,
                  itemBuilder: (context, index, realIndex) =>
                      NewReadingCard(data: history[index]),
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    aspectRatio: 2.0,
                    viewportFraction: 1,
                  ),
                )
              ],
            ),
        error: (error, stackTrace) => const SizedBox(),
        loading: () => const SizedBox());
  }
}
