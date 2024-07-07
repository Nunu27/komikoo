import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:komikoo/domain/models/feed/carousel_item.dart';
import 'package:komikoo/presentation/pages/feed/widgets/carousel_card.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselFeedView extends StatefulWidget {
  final List<CarouselItem> items;

  const CarouselFeedView({super.key, required this.items});

  @override
  State<CarouselFeedView> createState() => _CarouselFeedViewState();
}

class _CarouselFeedViewState extends State<CarouselFeedView> {
  final CarouselController _controller = CarouselController();
  double offset = 0;

  double getOffset(double raw) {
    final mod = (raw - 10000) % widget.items.length;

    return mod < 0 ? widget.items.length + mod : mod;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: _controller,
          itemCount: widget.items.length,
          itemBuilder: (context, index, realIndex) =>
              CarouselCard(data: widget.items[index]),
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 2.0,
            viewportFraction: 1,
            onScrolled: (value) => setState(() {
              offset = getOffset(value!);
            }),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          alignment: Alignment.centerRight,
          child: SmoothIndicator(
            offset: offset,
            size: const Size(95, 20),
            count: widget.items.length,
            onDotClicked: (index) => _controller.animateToPage(index),
            effect: ExpandingDotsEffect(
              dotColor: theme.colorScheme.outline,
              activeDotColor: theme.colorScheme.primary,
              dotHeight: 8,
              dotWidth: 8,
            ),
          ),
        )
      ],
    );
  }
}
