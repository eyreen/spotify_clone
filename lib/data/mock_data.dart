// WHAT IT DOES: Import our data models
import '../models/song.dart';
import '../models/playlist.dart';
import '../models/album.dart';

// WHAT IT DOES: This file contains fake/sample data for testing the app
// In a real app, this data would come from a server/API like Spotify's API
// TERM: Mock Data - Fake data used for testing and development

class MockData {
  // TERM: static - Belongs to the class itself, not to instances
  // WHAT IT DOES: Can access this data anywhere using MockData.songs
  // TERM: final - Can't reassign the list, but can modify its contents

  // List of sample songs with fake music URLs
  static final List<Song> songs = [
    Song(
      id: '1',
      title: 'Blinding Lights',
      artist: 'The Weeknd',
      album: 'After Hours',
      coverUrl: 'https://picsum.photos/seed/1/400',
      duration: const Duration(minutes: 3, seconds: 20),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
    ),
    Song(
      id: '2',
      title: 'Levitating',
      artist: 'Dua Lipa',
      album: 'Future Nostalgia',
      coverUrl: 'https://picsum.photos/seed/2/400',
      duration: const Duration(minutes: 3, seconds: 23),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
    ),
    Song(
      id: '3',
      title: 'Save Your Tears',
      artist: 'The Weeknd',
      album: 'After Hours',
      coverUrl: 'https://picsum.photos/seed/3/400',
      duration: const Duration(minutes: 3, seconds: 35),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
    ),
    Song(
      id: '4',
      title: 'Peaches',
      artist: 'Justin Bieber',
      album: 'Justice',
      coverUrl: 'https://picsum.photos/seed/4/400',
      duration: const Duration(minutes: 3, seconds: 18),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3',
    ),
    Song(
      id: '5',
      title: 'Good 4 U',
      artist: 'Olivia Rodrigo',
      album: 'SOUR',
      coverUrl: 'https://picsum.photos/seed/5/400',
      duration: const Duration(minutes: 2, seconds: 58),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3',
    ),
    Song(
      id: '6',
      title: 'Stay',
      artist: 'The Kid LAROI & Justin Bieber',
      album: 'Stay',
      coverUrl: 'https://picsum.photos/seed/6/400',
      duration: const Duration(minutes: 2, seconds: 21),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-6.mp3',
    ),
    Song(
      id: '7',
      title: 'Montero',
      artist: 'Lil Nas X',
      album: 'Montero',
      coverUrl: 'https://picsum.photos/seed/7/400',
      duration: const Duration(minutes: 2, seconds: 17),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-7.mp3',
    ),
    Song(
      id: '8',
      title: 'Kiss Me More',
      artist: 'Doja Cat ft. SZA',
      album: 'Planet Her',
      coverUrl: 'https://picsum.photos/seed/8/400',
      duration: const Duration(minutes: 3, seconds: 28),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-8.mp3',
    ),
  ];

  // List of sample playlists (curated collections of songs)
  // WHAT IT DOES: Each playlist contains a subset of songs from the songs list above
  static final List<Playlist> playlists = [
    Playlist(
      id: 'p1',
      name: 'Today\'s Top Hits',  // TERM: \' escapes the apostrophe so it doesn't end the string
      coverUrl: 'https://picsum.photos/seed/p1/400',
      description: 'Ed Sheeran is on top of the Hottest 50!',
      // TERM: sublist(0, 4) - Creates a new list from index 0 to 3 (4 is exclusive)
      // This playlist has songs at indexes 0, 1, 2, 3 from the songs list
      songs: songs.sublist(0, 4),
    ),
    Playlist(
      id: 'p2',
      name: 'RapCaviar',
      coverUrl: 'https://picsum.photos/seed/p2/400',
      description: 'New music from Lil Baby, Gunna and Lil Durk.',
      // This playlist has songs at indexes 4, 5, 6, 7
      songs: songs.sublist(4, 8),
    ),
    Playlist(
      id: 'p3',
      name: 'All Out 2010s',
      coverUrl: 'https://picsum.photos/seed/p3/400',
      description: 'The biggest songs of the 2010s.',
      // This playlist includes ALL songs (no sublist = entire list)
      songs: songs,
    ),
    Playlist(
      id: 'p4',
      name: 'Rock Classics',
      coverUrl: 'https://picsum.photos/seed/p4/400',
      description: 'Rock legends & epic songs.',
      // First 3 songs only (indexes 0, 1, 2)
      songs: songs.sublist(0, 3),
    ),
    Playlist(
      id: 'p5',
      name: 'Chill Hits',
      coverUrl: 'https://picsum.photos/seed/p5/400',
      description: 'Kick back to the best new and recent chill hits.',
      // Songs from index 2 to 5 (indexes 2, 3, 4, 5)
      songs: songs.sublist(2, 6),
    ),
  ];

  // List of sample albums (official releases by artists)
  // WHAT IT DOES: Albums group songs by the same artist from the same release
  static final List<Album> albums = [
    Album(
      id: 'a1',
      name: 'After Hours',
      artist: 'The Weeknd',
      coverUrl: 'https://picsum.photos/seed/a1/400',
      year: 2020,
      // TERM: [songs[0], songs[2]] - Creates a list with specific songs by their index
      // This album contains "Blinding Lights" (index 0) and "Save Your Tears" (index 2)
      songs: [songs[0], songs[2]],
    ),
    Album(
      id: 'a2',
      name: 'Future Nostalgia',
      artist: 'Dua Lipa',
      coverUrl: 'https://picsum.photos/seed/a2/400',
      year: 2020,
      // Just one song: "Levitating"
      songs: [songs[1]],
    ),
    Album(
      id: 'a3',
      name: 'Justice',
      artist: 'Justin Bieber',
      coverUrl: 'https://picsum.photos/seed/a3/400',
      year: 2021,
      // Just one song: "Peaches"
      songs: [songs[3]],
    ),
  ];

  // List of URLs for recently played items (just placeholder images for now)
  // WHAT IT DOES: In a real app, this would be actual album covers of recently played music
  static final List<String> recentlyPlayed = [
    'https://picsum.photos/seed/r1/300',  // Random image 1
    'https://picsum.photos/seed/r2/300',  // Random image 2
    'https://picsum.photos/seed/r3/300',  // Random image 3
    'https://picsum.photos/seed/r4/300',  // Random image 4
    'https://picsum.photos/seed/r5/300',  // Random image 5
    'https://picsum.photos/seed/r6/300',  // Random image 6
  ];
}
