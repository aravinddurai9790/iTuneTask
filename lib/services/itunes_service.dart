import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/media_item.dart';
import '../utils/ssl_pinning.dart';

class ItunesService {
  Future<List<MediaItem>> searchMedia(String query) async {
    final url = 'https://itunes.apple.com/search?term=$query&entity=allTrack&limit=50';

    if (await SSLPinning.checkSSL(url)) {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List results = data['results'];
        return results.map((json) => MediaItem.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load media');
      }
    } else {
      throw Exception('SSL Pinning failed');
    }
  }
}
