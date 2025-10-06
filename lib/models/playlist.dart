// WHAT IT DOES: Import the Song class so we can use it in this file
import 'song.dart';

// TERM: Model/Data Class - Defines what data a Playlist object contains
// WHAT IT DOES: This class represents a custom playlist (like "My Favorites" or "Workout Mix")
// DIFFERENCE FROM ALBUM: Albums are official releases by artists, playlists are custom collections
class Playlist {
  // WHAT IT DOES: A unique identifier for this playlist (like "playlist_789")
  final String id;

  // WHAT IT DOES: The name of the playlist (e.g., "Chill Vibes", "Workout Mix")
  final String name;

  // WHAT IT DOES: URL/path to the playlist cover image
  final String coverUrl;

  // TERM: List<Song> - A list (array) that can hold multiple Song objects
  // WHAT IT DOES: All the songs added to this playlist
  // NOTE: Unlike albums, playlists can have songs from different artists/albums
  final List<Song> songs;

  // WHAT IT DOES: A short description of what this playlist is about
  // (e.g., "Perfect songs for studying" or "Top hits of 2024")
  final String description;

  // TERM: Constructor - Special function that creates a new Playlist object
  Playlist({
    required this.id,
    required this.name,
    required this.coverUrl,
    required this.songs,
    // TERM: Default value - If description is not provided, defaults to empty string
    this.description = '',
  });
}

// EXAMPLE OF CREATING A PLAYLIST:
// Playlist myPlaylist = Playlist(
//   id: 'playlist1',
//   name: 'My Favorites',
//   coverUrl: 'https://example.com/playlist-cover.jpg',
//   songs: [song1, song5, song12], // Can be songs from different albums
//   description: 'My all-time favorite tracks',
// );
