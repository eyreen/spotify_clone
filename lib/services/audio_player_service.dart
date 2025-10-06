// Import the just_audio package - external library for playing audio
import 'package:just_audio/just_audio.dart';
// Import our Song model to work with song data
import '../models/song.dart';

// AudioPlayerService manages all audio playback in the app
// Uses Singleton pattern - only ONE instance exists throughout the app
class AudioPlayerService {
  // Create a single private instance of this class (stored in memory once)
  static final AudioPlayerService _instance = AudioPlayerService._internal();

  // Factory constructor - returns the same instance every time you call AudioPlayerService()
  factory AudioPlayerService() => _instance;

  // Private constructor - prevents creating new instances from outside
  AudioPlayerService._internal();

  // The actual audio player object that does the heavy lifting
  final AudioPlayer _player = AudioPlayer();

  // Stores the currently playing song (null if nothing is playing)
  Song? _currentSong;

  // List of songs in the current queue/playlist
  List<Song> _playlist = [];

  // Track which song in the playlist is currently playing (0 = first song)
  int _currentIndex = 0;

  // Getters - Allow other parts of the app to READ these values (but not change them directly)

  // Get access to the underlying audio player
  AudioPlayer get player => _player;

  // Get the current song that's playing
  Song? get currentSong => _currentSong;

  // Get the current playlist/queue
  List<Song> get playlist => _playlist;

  // Get the index of current song in playlist
  int get currentIndex => _currentIndex;

  // Streams - These broadcast real-time updates that the UI can listen to

  // Broadcasts current playback position (updates every second, e.g. "0:30")
  Stream<Duration> get positionStream => _player.positionStream;

  // Broadcasts total song duration (e.g. "3:45")
  Stream<Duration?> get durationStream => _player.durationStream;

  // Broadcasts player state (playing, paused, buffering, completed)
  Stream<PlayerState> get playerStateStream => _player.playerStateStream;

  // Broadcasts true/false if music is currently playing
  Stream<bool> get playingStream => _player.playingStream;

  // Initialize audio session - call this when app starts
  // Future<void> means this runs in background and doesn't return a value
  // async allows us to use 'await' for time-consuming operations
  Future<void> init() async {
    try {
      // Load a silent audio file to "warm up" the player
      // This prepares the audio session for playback
      await _player.setAudioSource(
        AudioSource.uri(Uri.parse('asset:///assets/silence.mp3')),
      );
    } catch (e) {
      // If initialization fails, print error instead of crashing the app
      print('Error initializing audio player: $e');
    }
  }

  // Play a specific song
  // Parameters: song to play, optional playlist (queue), optional index in playlist
  // Curly braces {} = optional named parameters
  Future<void> playSong(Song song, {List<Song>? playlist, int? index}) async {
    try {
      // Store this song as the currently playing song
      _currentSong = song;

      // If a playlist was provided, save it for skip next/previous functionality
      if (playlist != null) {
        _playlist = playlist;
        // Save the index, or use 0 if null (the ?? operator)
        _currentIndex = index ?? 0;
      }

      // Only play if the song has a valid audio URL
      if (song.audioUrl.isNotEmpty) {
        // Load the audio from URL (await = wait for it to load)
        await _player.setUrl(song.audioUrl);
        // Start playing the audio
        await _player.play();
      }
    } catch (e) {
      // If something goes wrong, print error instead of crashing
      print('Error playing song: $e');
    }
  }

  // Toggle between play and pause - used when user taps the play/pause button
  Future<void> togglePlayPause() async {
    // Check if currently playing
    if (_player.playing) {
      // If playing, then pause
      await _player.pause();
    } else {
      // If paused, then play
      await _player.play();
    }
  }

  // Pause the current song
  Future<void> pause() async {
    await _player.pause();
  }

  // Resume/Play the current song
  Future<void> play() async {
    await _player.play();
  }

  // Stop playback completely (different from pause - resets position)
  Future<void> stop() async {
    await _player.stop();
  }

  // Jump to a specific position in the song (e.g., skip to 1:30)
  // Used when user drags the progress bar
  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  // Skip to the next song in the playlist
  Future<void> skipNext() async {
    // If no playlist, exit early
    if (_playlist.isEmpty) return;

    // Move to next song index
    // % (modulo) makes it wrap around: if at last song, go back to first song
    // Example: if length is 10 and currentIndex is 9, (9+1) % 10 = 0 (back to start)
    _currentIndex = (_currentIndex + 1) % _playlist.length;

    // Play the song at the new index
    await playSong(_playlist[_currentIndex], playlist: _playlist, index: _currentIndex);
  }

  // Skip to the previous song in the playlist
  Future<void> skipPrevious() async {
    // If no playlist, exit early
    if (_playlist.isEmpty) return;

    // If more than 3 seconds into the song, restart current song instead of going back
    // This mimics Spotify behavior
    if ((_player.position.inSeconds) > 3) {
      // Jump back to the beginning (Duration.zero = 0:00)
      await _player.seek(Duration.zero);
      // Resume playing
      await _player.play();
    } else {
      // Go to previous song
      // Add _playlist.length to prevent negative numbers before using modulo
      // Example: if currentIndex is 0, (0-1+10) % 10 = 9 (wraps to end)
      _currentIndex = (_currentIndex - 1 + _playlist.length) % _playlist.length;
      // Play the song at the new index
      await playSong(_playlist[_currentIndex], playlist: _playlist, index: _currentIndex);
    }
  }

  // Set the volume level
  // volume: 0.0 = silent, 1.0 = maximum volume
  Future<void> setVolume(double volume) async {
    // clamp ensures the value stays between 0.0 and 1.0
    // If you pass 1.5, it becomes 1.0. If you pass -0.2, it becomes 0.0
    await _player.setVolume(volume.clamp(0.0, 1.0));
  }

  // Enable or disable shuffle mode
  // When enabled, songs play in random order
  Future<void> setShuffleMode(bool enabled) async {
    await _player.setShuffleModeEnabled(enabled);
  }

  // Set how songs repeat
  // LoopMode.off = no repeat
  // LoopMode.one = repeat current song
  // LoopMode.all = repeat entire playlist
  Future<void> setLoopMode(LoopMode mode) async {
    await _player.setLoopMode(mode);
  }

  // Clean up resources when app closes
  // Prevents memory leaks by releasing the audio player
  void dispose() {
    _player.dispose();
  }
}
