import 'package:flutter/material.dart';
import '../models/media_item.dart';
import '../views/media_details_page.dart';

class MediaList extends StatelessWidget {
  final List<MediaItem> mediaList;

  const MediaList({super.key, required this.mediaList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: mediaList.length,
      itemBuilder: (context, index) {
        final item = mediaList[index];
        return ListTile(
          leading: Image.network(item.artworkUrl),
          title: Text(item.title),
          subtitle: Text('${item.artist} • ${item.mediaType}'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MediaDetailsPage(mediaItem: item),
              ),
            );
          },
        );
      },
    );
  }
}
