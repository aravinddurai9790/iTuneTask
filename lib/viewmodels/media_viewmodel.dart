import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/itunes_service.dart';
import '../models/media_item.dart';

final mediaViewModelProvider = StateNotifierProvider<MediaViewModel, AsyncValue<List<MediaItem>>>((ref) {
  return MediaViewModel(ItunesService());
});

class MediaViewModel extends StateNotifier<AsyncValue<List<MediaItem>>> {
  final ItunesService _itunesService;

  MediaViewModel(this._itunesService) : super(AsyncValue.loading());

  Future<void> searchMedia(String query) async {
    try {
      final results = await _itunesService.searchMedia(query);
      state = AsyncValue.data(results);
    } catch (e) {
      state = AsyncValue.error(e,StackTrace.current);
    }
  }
}
