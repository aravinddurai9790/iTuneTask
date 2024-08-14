// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:itunes_task/main.dart';
import 'package:itunes_task/models/media_item.dart';
import 'package:itunes_task/services/itunes_service.dart';
import 'package:itunes_task/viewmodels/media_viewmodel.dart';
import 'package:mockito/mockito.dart';
class MockItunesService extends Mock implements ItunesService {}

void main() {
  group('MediaViewModel', () {
    late MediaViewModel viewModel;
    late MockItunesService mockItunesService;

    setUp(() {
      mockItunesService = MockItunesService();
      viewModel = MediaViewModel(mockItunesService);
    });

    test('searchMedia returns results on success', () async {
      when(mockItunesService.searchMedia('test')).thenAnswer((_) async => [
            MediaItem(
              title: 'Test Song',
              artist: 'Test Artist',
              artworkUrl: '',
              mediaType: 'song',
              previewUrl: '',
            ),
          ]);

      await viewModel.searchMedia('test');

      expect(viewModel.state, isA<AsyncValue<List<MediaItem>>>());
      expect(viewModel.state.asData?.value.length, 1);
    });

    // More tests...
  });}
