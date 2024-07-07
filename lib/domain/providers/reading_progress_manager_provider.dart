import 'package:bot_toast/bot_toast.dart';
import 'package:komikoo/constants/constants.dart';
import 'package:komikoo/data/database/database.dart';
import 'package:komikoo/domain/controllers/history_controller.dart';
import 'package:komikoo/domain/models/chapter/chapter.dart';
import 'package:komikoo/utils/debouncer.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reading_progress_manager_provider.g.dart';

@riverpod
class ReadingProgressManager extends _$ReadingProgressManager {
  final _debouncer = Debouncer(milliseconds: 500);
  Chapter? _chapter;
  String? _comicSlug;

  double? _lastProgress;
  bool _interacting = false;
  DateTime? _locked;
  void Function(double)? _onNavigate;

  @override
  double build(String comicSlug) {
    _comicSlug = comicSlug;

    return 0;
  }

  void resetChapter() {
    state = 0;
    _chapter = null;
    _lastProgress = null;
    navigateTo(0);
  }

  void setChapter(Chapter chapter) {
    if (_chapter == chapter) return;
    _chapter = chapter;
    getLastProgress();
  }

  Future<void> getLastProgress() async {
    final current = DateTime.now();

    _locked = current;
    final historyDao = ref.read(databaseProvider).historyDao;
    final result = await historyDao.getProgress(_chapter!.hid);
    if (_locked != current) return;
    _locked = null;

    result.fold(
      (error) => BotToast.showText(text: 'Failed to get reading progress'),
      (progress) {
        _lastProgress = progress ?? 0;
        restoreProgress();
      },
    );
  }

  void restoreProgress() {
    if (_lastProgress == null || _lastProgress == 0) return;
    navigateTo(_lastProgress!);
    BotToast.showText(text: 'Reading progress restored');
  }

  void setOnNavigate(void Function(double percentage) onNavigate) {
    _onNavigate = onNavigate;

    if (_lastProgress == null && _locked == null) {
      getLastProgress();
    } else {
      restoreProgress();
    }
  }

  void navigateTo(double percentage) {
    if (_onNavigate == null) return;
    _onNavigate!(percentage);
  }

  void updatePercentage(double percentage) {
    state = percentage;
    if (_interacting || _locked != null || state < Constants.minimumProgress) {
      return;
    }
    _debouncer.run(updateProgress);
  }

  void onInteractionStart() {
    _interacting = true;
  }

  void onInteractionEnd() {
    _interacting = false;
  }

  void updateProgress() async {
    if (_chapter == null || _locked != null) return;
    if (_lastProgress == null) await getLastProgress();
    if (state <= _lastProgress!) return;

    _lastProgress = state;
    ref.read(historyControllerProvider).updateProgress(
          chapter: _chapter!,
          comicSlug: _comicSlug!,
          progress: state,
        );
  }
}
