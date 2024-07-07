import 'package:flutter/material.dart';

class HeightConstants {
  static const coverRatio = 225 / 350;

  // Details
  static const detailsHeaderHeight = 270.0;
  static const headerEdge = detailsHeaderHeight - kToolbarHeight;
  static const actionEdge = 75;
  static const chapterHeaderHeight = kToolbarHeight + 14;

  // Reader overlay
  static const progressHeight = 3.0;
  static const bottomBarHeight = kBottomNavigationBarHeight + progressHeight;
  static const showOffset = kBottomNavigationBarHeight / bottomBarHeight;

  static const floatingButtonHeight = 86.0;
  static const chapterLoaderHeight = 200.0;
  static const chapterTileHeight = 72.0;
  static const chapterTileCompactHeight = 56.0;
  static const historyCardHeight = 100.0;
}
