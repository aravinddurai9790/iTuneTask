import 'package:flutter/material.dart';
import '../models/media_item.dart';
import '../views/media_details_page.dart';

class MediaGrid extends StatelessWidget {
  final List<MediaItem> mediaList;

  const MediaGrid({super.key, required this.mediaList});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.9,
      ),
      itemCount: mediaList.length,
      itemBuilder: (context, index) {
        final item = mediaList[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MediaDetailsPage(mediaItem: item),
              ),
            );
          },
          child: Card(
            child: Column(
              children: [
                Image.network(item.artworkUrl),
                Text(item.title),
                Text(item.artist),
                Text(item.mediaType),
              ],
            ),
          ),
        );
      },
    );
  }
}
