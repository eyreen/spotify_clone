import 'song.dart';

class Album {
  final String id;
  final String name;
  final String artist;
  final String coverUrl;
  final List<Song> songs;
  final int year;

  Album({
    required this.id,
    required this.name,
    required this.artist,
    required this.coverUrl,
    required this.songs,
    required this.year,
  });
}
