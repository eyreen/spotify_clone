// TERM: Model/Data Class - A blueprint that defines what data a Song object contains
// WHAT IT DOES: This class represents a single song with all its information
// Think of it like a form with fields for song details
class Song {
  // TERM: final - These properties can't be changed after the song is created
  // TERM: String - Text data type (letters, numbers, symbols)

  // WHAT IT DOES: A unique identifier for this song (like "song_123")
  final String id;

  // WHAT IT DOES: The name of the song (e.g., "Blinding Lights")
  final String title;

  // WHAT IT DOES: Who sang/performed the song (e.g., "The Weeknd")
  final String artist;

  // WHAT IT DOES: Which album this song belongs to (e.g., "After Hours")
  final String album;

  // WHAT IT DOES: URL/path to the album cover image
  final String coverUrl;

  // TERM: Duration - A time period (like 3 minutes, 30 seconds)
  // WHAT IT DOES: How long the song is
  final Duration duration;

  // WHAT IT DOES: URL/path to the actual audio file (MP3, etc.)
  final String audioUrl;

  // TERM: Constructor - Special function that creates a new Song object
  // TERM: required - These parameters MUST be provided when creating a Song
  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.coverUrl,
    required this.duration,
    // TERM: Default value - If audioUrl is not provided, it defaults to empty string ''
    this.audioUrl = '',
  });
}

// EXAMPLE OF CREATING A SONG:
// Song mySong = Song(
//   id: '1',
//   title: 'Blinding Lights',
//   artist: 'The Weeknd',
//   album: 'After Hours',
//   coverUrl: 'https://example.com/cover.jpg',
//   duration: Duration(minutes: 3, seconds: 20),
//   audioUrl: 'https://example.com/song.mp3',
// );
