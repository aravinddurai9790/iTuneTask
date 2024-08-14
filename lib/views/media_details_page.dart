import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/media_item.dart';

class MediaDetailsPage extends StatelessWidget {
  final MediaItem mediaItem;

  const MediaDetailsPage({super.key, required this.mediaItem});

  Future<void> _playPreview(BuildContext context,String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      _showErrorSnackBar(context, 'Could not launch the preview.');
    }
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mediaItem.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                mediaItem.artworkUrl,
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              mediaItem.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              mediaItem.artist,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Text(
              'Media Type: ${mediaItem.mediaType}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            if (mediaItem.previewUrl.isNotEmpty)
              ElevatedButton.icon(
                onPressed: () async {
                  _playPreview(context,mediaItem.previewUrl);
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text('Play Preview'),
              ),
          ],
        ),
      ),
    );
  }
}
