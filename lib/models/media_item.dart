class MediaItem {
  final String title;
  final String artist;
  final String artworkUrl;
  final String mediaType;
  final String previewUrl;

  MediaItem({
    required this.title,
    required this.artist,
    required this.artworkUrl,
    required this.mediaType,
    required this.previewUrl,
  });

  factory MediaItem.fromJson(Map<String, dynamic> json) {
    return MediaItem(
      title: json['trackName'] ?? 'No Title',
      artist: json['artistName'] ?? 'No Artist',
      artworkUrl: json['artworkUrl100'] ?? '',
      mediaType: json['kind'] ?? 'Unknown',
      previewUrl: json['previewUrl'] ?? '',
    );
  }
}
