import 'package:flutter/material.dart';
import 'package:komikoo/domain/models/feed/carousel_item.dart';
import 'package:komikoo/domain/models/feed/feed.dart';
import 'package:komikoo/presentation/pages/feed/widgets/carousel_feed_view.dart';

class CarouselFeed extends Feed {
  final List<CarouselItem> items;

  CarouselFeed({required this.items});

  @override
  Widget build() {
    return CarouselFeedView(items: items);
  }
}
