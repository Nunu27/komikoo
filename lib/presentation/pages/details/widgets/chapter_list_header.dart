import 'package:flutter/material.dart';
import 'package:komikoo/constants/height_constants.dart';
import 'package:komikoo/domain/models/chapter/chapter.dart';

class ChapterListHeader extends StatelessWidget {
  final List<Language> languages;
  final void Function(Language?)? onLanguageChange;

  const ChapterListHeader({
    super.key,
    required this.languages,
    this.onLanguageChange,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final haveMultipleLanguage = languages.length > 2;

    return SliverAppBar(
      pinned: true,
      primary: false,
      automaticallyImplyLeading: false,
      shape: Border(
        bottom: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      toolbarHeight: HeightConstants.chapterHeaderHeight,
      title: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Chapters',
                  style: theme.textTheme.titleMedium,
                ),
                if (haveMultipleLanguage)
                  Text(
                    'Available in ${languages.length - 1} languages',
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: theme.colorScheme.onBackground.withOpacity(0.8),
                    ),
                  )
              ],
            ),
          ),
          DropdownMenu(
            initialSelection: Language.all,
            onSelected: onLanguageChange,
            width: 150,
            menuHeight: 500,
            menuStyle: const MenuStyle(
              padding: MaterialStatePropertyAll(EdgeInsets.zero),
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: theme.colorScheme.surfaceTint.withOpacity(0.05),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide.none,
              ),
              constraints: const BoxConstraints(maxHeight: kToolbarHeight - 7),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14),
            ),
            textStyle: const TextStyle(
              fontSize: 12,
            ),
            dropdownMenuEntries: languages
                .map(
                  (language) => DropdownMenuEntry(
                    value: language,
                    label: language.label,
                    labelWidget: Text(
                      language.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
