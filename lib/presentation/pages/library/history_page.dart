import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:komikoo/domain/controllers/history_controller.dart';
import 'package:komikoo/domain/models/comic/comic_with_progress.dart';
import 'package:komikoo/presentation/pages/library/widgets/history_card.dart';
import 'package:komikoo/presentation/widgets/error_view.dart';
import 'package:komikoo/presentation/widgets/loader.dart';
import 'package:komikoo/utils/formatter.dart';

@RoutePage()
class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void deleteHistory(String hid) {
      ref.read(historyControllerProvider).deleteHistory(hid);
    }

    return ref.watch(historyListProvider()).when(
          data: (history) {
            if (history.isEmpty) return const ErrorView(message: 'Still empty');

            return GroupedListView<ComicWithProgress, String>(
              elements: history,
              scrollDirection: Axis.vertical,
              order: GroupedListOrder.DESC,
              padding: const EdgeInsets.symmetric(vertical: 7),
              groupBy: (element) => element.date.toDateString(),
              itemComparator: (a, b) => a.date.compareTo(b.date),
              groupSeparatorBuilder: (date) => Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 7,
                ),
                child: Text(date),
              ),
              itemBuilder: (context, data) => HistoryCard(
                data: data,
                onDelete: deleteHistory,
              ),
            );
          },
          error: (error, stackTrace) => ErrorView(
            message: error.toString(),
            onRetry: () => ref.invalidate(historyListProvider),
          ),
          loading: () => const Loader(),
        );
  }
}
