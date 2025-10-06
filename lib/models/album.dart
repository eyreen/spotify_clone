// WHAT IT DOES: Import the Song class so we can use it in this file
import 'song.dart';

// TERM: Model/Data Class - Defines what data an Album object contains
// WHAT IT DOES: This class represents a music album with multiple songs
// Think of it like a CD or vinyl record that has many songs on it
class Album {
  // WHAT IT DOES: A unique identifier for this album (like "album_456")
  final String id;

  // WHAT IT DOES: The name of the album (e.g., "After Hours")
  final String name;

  // WHAT IT DOES: The artist/band who created the album (e.g., "The Weeknd")
  final String artist;

  // WHAT IT DOES: URL/path to the album cover art image
  final String coverUrl;

  // TERM: List<Song> - A list (array) that can hold multiple Song objects
  // WHAT IT DOES: All the songs that are part of this album
  final List<Song> songs;

  // TERM: int - Integer (whole number) data type
  // WHAT IT DOES: The year this album was released (e.g., 2020)
  final int year;

  // TERM: Constructor - Special function that creates a new Album object
  Album({
    required this.id,
    required this.name,
    required this.artist,
    required this.coverUrl,
    required this.songs,
    required this.year,
  });
}

// EXAMPLE OF CREATING AN ALBUM:
// Album myAlbum = Album(
//   id: 'album1',
//   name: 'After Hours',
//   artist: 'The Weeknd',
//   coverUrl: 'https://example.com/album-cover.jpg',
//   songs: [song1, song2, song3], // List of Song objects
//   year: 2020,
// );
