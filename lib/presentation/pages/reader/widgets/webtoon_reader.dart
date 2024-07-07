import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:komikoo/domain/models/chapter/chapter_content.dart';
import 'package:komikoo/domain/providers/reading_progress_manager_provider.dart';
import 'package:komikoo/presentation/widgets/loader.dart';

class WebtoonReader extends ConsumerStatefulWidget {
  final int totalHeight;
  final VoidCallback hideOverlay;
  final List<ChapterContent> contents;
  final ReadingProgressManagerProvider managerProvider;

  const WebtoonReader({
    super.key,
    required this.totalHeight,
    required this.hideOverlay,
    required this.contents,
    required this.managerProvider,
  });

  @override
  ConsumerState<WebtoonReader> createState() => _WebtoonReaderState();
}

class _WebtoonReaderState extends ConsumerState<WebtoonReader>
    with TickerProviderStateMixin {
  final _renderExtent = 500;

  final _transformationController = TransformationController();
  late final AnimationController _animationController;
  late final double? _totalHeight;
  Animation<Matrix4>? _animatedTransform;

  double get endOffset {
    final screenHeight = MediaQuery.of(context).size.height;
    return _totalHeight! - screenHeight;
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Durations.medium1,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _totalHeight = _calculateHeight(
        MediaQuery.of(context).size.width,
        widget.contents[0].w,
        widget.totalHeight,
      );

      ref.read(widget.managerProvider.notifier).setOnNavigate(_onNavigate);
      _transformationController.addListener(() {
        if (!mounted) return;

        final yOffset = _transformationController.value.row1.a /
            _transformationController.value.row1.g;

        ref
            .read(widget.managerProvider.notifier)
            .updatePercentage(max(0, -yOffset) / endOffset);
      });
    });
  }

  @override
  void dispose() {
    _transformationController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  double _calculateHeight(double screenWidth, int width, int height) {
    return screenWidth / width * height;
  }

  double _clamp(double value, double upper, double lower) {
    return max(lower, min(upper, value));
  }

  Matrix4 _calculateTransform(
    MediaQueryData mediaQuery,
    TapDownDetails details,
  ) {
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final totalHeight = _calculateHeight(
      screenWidth,
      widget.contents[0].w,
      widget.totalHeight,
    );

    final matrix = _transformationController.value.clone();

    final tapPosition = details.localPosition;
    final targetScale = matrix.row0.r > 1.5 ? 1.0 : 2.0;

    final xBoundary = screenWidth * targetScale - screenWidth;
    final yBoundary = totalHeight * targetScale - screenHeight;

    final scale = targetScale / matrix.row0.r;
    final newX = min(0, matrix.row0.a - tapPosition.dx) * scale;
    final newY = min(0, matrix.row1.a - tapPosition.dy) * scale;

    final xOffset = screenWidth / 2;
    final yOffset = screenHeight / 2 +
        (scale < 1 ? -mediaQuery.padding.top : mediaQuery.padding.top);

    matrix.scale(scale);
    matrix.setEntry(0, 3, _clamp(newX + xOffset, 0, -xBoundary));
    matrix.setEntry(1, 3, _clamp(newY + yOffset, 0, -yBoundary));

    return matrix;
  }

  void _updateTransform() {
    _transformationController.value = _animatedTransform!.value;
    if (!_animationController.isAnimating) {
      _animatedTransform!.removeListener(_updateTransform);
      _animatedTransform = null;
      _animationController.reset();
    }
  }

  void _handleZoom(MediaQueryData mediaQuery, TapDownDetails details) {
    _animateTransform(_calculateTransform(mediaQuery, details));
  }

  void _onNavigate(double percentage) {
    _animateTransform(
        Matrix4.identity()..setEntry(1, 3, -(endOffset * percentage)));
  }

  void _animateTransform(Matrix4 target) {
    _animationController.reset();
    _animatedTransform = Matrix4Tween(
      begin: _transformationController.value,
      end: target,
    ).animate(_animationController);
    _animatedTransform!.addListener(_updateTransform);
    _animationController.forward();
  }

  void _stopAnimation() {
    _animationController.stop();
    _animatedTransform?.removeListener(_updateTransform);
    _animatedTransform = null;
    _animationController.reset();
  }

  void _onInteractionStart(_) {
    ref.read(widget.managerProvider.notifier).onInteractionStart();
    widget.hideOverlay();
    if (_animationController.status == AnimationStatus.forward) {
      _stopAnimation();
    }
  }

  void _onInteractionEnd(_) {
    ref.read(widget.managerProvider.notifier).onInteractionEnd();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    final totalHeight = _calculateHeight(
      screenWidth,
      widget.contents[0].w,
      widget.totalHeight,
    );

    return GestureDetector(
      onDoubleTapDown: (details) => _handleZoom(mediaQuery, details),
      child: InteractiveViewer.builder(
        transformationController: _transformationController,
        onInteractionStart: _onInteractionStart,
        onInteractionEnd: _onInteractionEnd,
        boundaryMargin: EdgeInsets.only(
          bottom: totalHeight,
          right: screenWidth,
        ),
        builder: (context, viewport) {
          final top = max(0, viewport.point0.y - _renderExtent);
          final bottom = viewport.point3.y + _renderExtent;

          double cumulativeY = 0;
          final visibleContent = <Widget>[];

          for (var content in widget.contents) {
            final height = _calculateHeight(screenWidth, content.w, content.h);
            final boundaryTop = cumulativeY;
            cumulativeY += height;
            final boundaryBottom = cumulativeY;

            if ((boundaryTop < top && boundaryBottom < top) ||
                (boundaryTop > bottom && boundaryBottom > bottom)) {
              continue;
            }

            visibleContent.add(
              Positioned(
                top: boundaryTop,
                width: screenWidth,
                child: CachedNetworkImage(
                  imageUrl: content.url,
                  height: height,
                  progressIndicatorBuilder: (context, url, progress) =>
                      Loader(value: progress.progress),
                  errorWidget: (context, url, error) => const Center(
                    child: Icon(Icons.broken_image_outlined),
                  ),
                ),
              ),
            );
          }

          return SizedBox(
            height: 0,
            width: 0,
            child: Stack(
              clipBehavior: Clip.none,
              children: visibleContent,
            ),
          );
        },
      ),
    );
  }
}
