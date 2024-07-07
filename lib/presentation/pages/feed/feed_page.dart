import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:komikoo/domain/controllers/comic_controller.dart';
import 'package:komikoo/presentation/widgets/error_view.dart';
import 'package:komikoo/presentation/widgets/loader.dart';
import 'package:komikoo/router/app_router.gr.dart';

@RoutePage()
class FeedPage extends ConsumerWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: kToolbarHeight - 28,
            ),
            const SizedBox(width: 7),
            const Text('Komikoo'),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.pushRoute(const SearchRoute());
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: ref.watch(getFeedProvider).when(
            skipLoadingOnRefresh: false,
            data: (feed) => RefreshIndicator(
              onRefresh: () => ref.refresh(getFeedProvider.future),
              child: ListView.builder(
                itemCount: feed.length,
                itemBuilder: (context, index) => feed[index].build(),
              ),
            ),
            error: (error, stackTrace) => ErrorView(
              message: error.toString(),
              onRetry: () => ref.invalidate(getFeedProvider),
            ),
            loading: () => const Loader(),
          ),
    );
  }
}
