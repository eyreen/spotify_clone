import '../models/song.dart';
import '../models/playlist.dart';
import '../models/album.dart';

class MockData {
  static final List<Song> songs = [
    Song(
      id: '1',
      title: 'Blinding Lights',
      artist: 'The Weeknd',
      album: 'After Hours',
      coverUrl: 'https://picsum.photos/seed/1/400',
      duration: const Duration(minutes: 3, seconds: 20),
    ),
    Song(
      id: '2',
      title: 'Levitating',
      artist: 'Dua Lipa',
      album: 'Future Nostalgia',
      coverUrl: 'https://picsum.photos/seed/2/400',
      duration: const Duration(minutes: 3, seconds: 23),
    ),
    Song(
      id: '3',
      title: 'Save Your Tears',
      artist: 'The Weeknd',
      album: 'After Hours',
      coverUrl: 'https://picsum.photos/seed/3/400',
      duration: const Duration(minutes: 3, seconds: 35),
    ),
    Song(
      id: '4',
      title: 'Peaches',
      artist: 'Justin Bieber',
      album: 'Justice',
      coverUrl: 'https://picsum.photos/seed/4/400',
      duration: const Duration(minutes: 3, seconds: 18),
    ),
    Song(
      id: '5',
      title: 'Good 4 U',
      artist: 'Olivia Rodrigo',
      album: 'SOUR',
      coverUrl: 'https://picsum.photos/seed/5/400',
      duration: const Duration(minutes: 2, seconds: 58),
    ),
    Song(
      id: '6',
      title: 'Stay',
      artist: 'The Kid LAROI & Justin Bieber',
      album: 'Stay',
      coverUrl: 'https://picsum.photos/seed/6/400',
      duration: const Duration(minutes: 2, seconds: 21),
    ),
    Song(
      id: '7',
      title: 'Montero',
      artist: 'Lil Nas X',
      album: 'Montero',
      coverUrl: 'https://picsum.photos/seed/7/400',
      duration: const Duration(minutes: 2, seconds: 17),
    ),
    Song(
      id: '8',
      title: 'Kiss Me More',
      artist: 'Doja Cat ft. SZA',
      album: 'Planet Her',
      coverUrl: 'https://picsum.photos/seed/8/400',
      duration: const Duration(minutes: 3, seconds: 28),
    ),
  ];

  static final List<Playlist> playlists = [
    Playlist(
      id: 'p1',
      name: 'Today\'s Top Hits',
      coverUrl: 'https://picsum.photos/seed/p1/400',
      description: 'Ed Sheeran is on top of the Hottest 50!',
      songs: songs.sublist(0, 4),
    ),
    Playlist(
      id: 'p2',
      name: 'RapCaviar',
      coverUrl: 'https://picsum.photos/seed/p2/400',
      description: 'New music from Lil Baby, Gunna and Lil Durk.',
      songs: songs.sublist(4, 8),
    ),
    Playlist(
      id: 'p3',
      name: 'All Out 2010s',
      coverUrl: 'https://picsum.photos/seed/p3/400',
      description: 'The biggest songs of the 2010s.',
      songs: songs,
    ),
    Playlist(
      id: 'p4',
      name: 'Rock Classics',
      coverUrl: 'https://picsum.photos/seed/p4/400',
      description: 'Rock legends & epic songs.',
      songs: songs.sublist(0, 3),
    ),
    Playlist(
      id: 'p5',
      name: 'Chill Hits',
      coverUrl: 'https://picsum.photos/seed/p5/400',
      description: 'Kick back to the best new and recent chill hits.',
      songs: songs.sublist(2, 6),
    ),
  ];

  static final List<Album> albums = [
    Album(
      id: 'a1',
      name: 'After Hours',
      artist: 'The Weeknd',
      coverUrl: 'https://picsum.photos/seed/a1/400',
      year: 2020,
      songs: [songs[0], songs[2]],
    ),
    Album(
      id: 'a2',
      name: 'Future Nostalgia',
      artist: 'Dua Lipa',
      coverUrl: 'https://picsum.photos/seed/a2/400',
      year: 2020,
      songs: [songs[1]],
    ),
    Album(
      id: 'a3',
      name: 'Justice',
      artist: 'Justin Bieber',
      coverUrl: 'https://picsum.photos/seed/a3/400',
      year: 2021,
      songs: [songs[3]],
    ),
  ];

  static final List<String> recentlyPlayed = [
    'https://picsum.photos/seed/r1/300',
    'https://picsum.photos/seed/r2/300',
    'https://picsum.photos/seed/r3/300',
    'https://picsum.photos/seed/r4/300',
    'https://picsum.photos/seed/r5/300',
    'https://picsum.photos/seed/r6/300',
  ];
}
