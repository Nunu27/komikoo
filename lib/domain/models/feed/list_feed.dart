import 'package:flutter/material.dart';
import 'package:komikoo/domain/models/feed/list_item.dart';
import 'package:komikoo/domain/models/feed/feed.dart';
import 'package:komikoo/presentation/pages/feed/widgets/list_feed_view.dart';

class ListFeed extends Feed {
  final String title;
  final List<ListItem> items;
  final Map<String, dynamic>? more;

  ListFeed({required this.title, required this.items, this.more});

  @override
  Widget build() {
    return ListFeedView(
      title: title,
      items: items,
      more: more,
    );
  }
}
