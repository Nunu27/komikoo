import 'package:flutter/material.dart';
import 'package:komikoo/domain/models/feed/feed.dart';
import 'package:komikoo/presentation/pages/feed/widgets/new_reading_feed_view.dart';
import 'package:komikoo/presentation/pages/feed/widgets/reading_feed_view.dart';

class ReadingFeed extends Feed {
  @override
  Widget build() {
    return const NewReadingView();
  }
}
