import 'package:flutter/material.dart';
import 'package:komikoo/constants/height_constants.dart';
import 'package:komikoo/presentation/widgets/cover/cover_image.dart';

class CoverImageWithRatio extends StatelessWidget {
  final String? cover;

  const CoverImageWithRatio({
    super.key,
    required this.cover,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: HeightConstants.coverRatio,
      child: CoverImage(cover: cover),
    );
  }
}
