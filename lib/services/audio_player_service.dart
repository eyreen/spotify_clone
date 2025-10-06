import 'package:just_audio/just_audio.dart';
import '../models/song.dart';

class AudioPlayerService {
  static final AudioPlayerService _instance = AudioPlayerService._internal();
  factory AudioPlayerService() => _instance;
  AudioPlayerService._internal();

  final AudioPlayer _player = AudioPlayer();
  Song? _currentSong;
  List<Song> _playlist = [];
  int _currentIndex = 0;

  // Getters
  AudioPlayer get player => _player;
  Song? get currentSong => _currentSong;
  List<Song> get playlist => _playlist;
  int get currentIndex => _currentIndex;

  // Streams
  Stream<Duration> get positionStream => _player.positionStream;
  Stream<Duration?> get durationStream => _player.durationStream;
  Stream<PlayerState> get playerStateStream => _player.playerStateStream;
  Stream<bool> get playingStream => _player.playingStream;

  // Initialize audio session
  Future<void> init() async {
    try {
      // Set up audio session for music playback
      await _player.setAudioSource(
        AudioSource.uri(Uri.parse('asset:///assets/silence.mp3')),
      );
    } catch (e) {
      print('Error initializing audio player: $e');
    }
  }

  // Play a song
  Future<void> playSong(Song song, {List<Song>? playlist, int? index}) async {
    try {
      _currentSong = song;
      if (playlist != null) {
        _playlist = playlist;
        _currentIndex = index ?? 0;
      }

      if (song.audioUrl.isNotEmpty) {
        await _player.setUrl(song.audioUrl);
        await _player.play();
      }
    } catch (e) {
      print('Error playing song: $e');
    }
  }

  // Play/Pause toggle
  Future<void> togglePlayPause() async {
    if (_player.playing) {
      await _player.pause();
    } else {
      await _player.play();
    }
  }

  // Pause
  Future<void> pause() async {
    await _player.pause();
  }

  // Resume/Play
  Future<void> play() async {
    await _player.play();
  }

  // Stop
  Future<void> stop() async {
    await _player.stop();
  }

  // Seek to position
  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  // Skip to next song
  Future<void> skipNext() async {
    if (_playlist.isEmpty) return;

    _currentIndex = (_currentIndex + 1) % _playlist.length;
    await playSong(_playlist[_currentIndex], playlist: _playlist, index: _currentIndex);
  }

  // Skip to previous song
  Future<void> skipPrevious() async {
    if (_playlist.isEmpty) return;

    // If more than 3 seconds played, restart current song
    if ((_player.position.inSeconds) > 3) {
      await _player.seek(Duration.zero);
      await _player.play();
    } else {
      _currentIndex = (_currentIndex - 1 + _playlist.length) % _playlist.length;
      await playSong(_playlist[_currentIndex], playlist: _playlist, index: _currentIndex);
    }
  }

  // Set volume (0.0 to 1.0)
  Future<void> setVolume(double volume) async {
    await _player.setVolume(volume.clamp(0.0, 1.0));
  }

  // Set shuffle mode
  Future<void> setShuffleMode(bool enabled) async {
    await _player.setShuffleModeEnabled(enabled);
  }

  // Set loop mode
  Future<void> setLoopMode(LoopMode mode) async {
    await _player.setLoopMode(mode);
  }

  // Dispose
  void dispose() {
    _player.dispose();
  }
}
