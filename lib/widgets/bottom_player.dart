// Import Flutter widgets
import 'package:flutter/material.dart';
// Import Song model
import '../models/song.dart';
// Import the full-screen player
import '../screens/player_screen.dart';
// Import audio service to control playback
import '../services/audio_player_service.dart';

// WHAT IT DOES: This is the mini music player that appears at the bottom of all screens
// Shows currently playing song and basic controls (play/pause)
// Tapping it opens the full-screen player
class BottomPlayer extends StatefulWidget {
  const BottomPlayer({super.key});

  @override
  State<BottomPlayer> createState() => _BottomPlayerState();
}

class _BottomPlayerState extends State<BottomPlayer> {
  // WHAT IT DOES: Get the singleton audio service instance
  // This service manages all audio playback throughout the app
  final AudioPlayerService _audioService = AudioPlayerService();

  @override
  void dispose() {
    super.dispose();
  }

  // WHAT IT DOES: Opens the full-screen player when user taps the mini player
  void _openPlayer() {
    // Only open if there's a song currently playing
    // TERM: ! (bang operator) - Tells Dart "I know this isn't null, trust me"
    if (_audioService.currentSong != null) {
      // TERM: Navigator.push - Navigate to a new screen
      Navigator.push(
        context,
        // TERM: PageRouteBuilder - Allows custom page transition animations
        PageRouteBuilder(
          // Build the new screen (PlayerScreen)
          pageBuilder: (context, animation, secondaryAnimation) =>
              PlayerScreen(song: _audioService.currentSong!),
          // TERM: transitionsBuilder - Defines how the screen animates in
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // TERM: Offset - Position coordinates (x, y)
            // Start position: (0.0, 1.0) = bottom of screen (below view)
            const begin = Offset(0.0, 1.0);
            // End position: (0.0, 0.0) = normal position (on screen)
            const end = Offset.zero;
            // TERM: Curves.easeInOut - Animation speed curve (starts slow, fast middle, ends slow)
            const curve = Curves.easeInOut;
            // TERM: Tween - Defines value change over time (from begin to end)
            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );
            // TERM: SlideTransition - Animates the position of a widget
            // WHAT IT DOES: Makes the player slide up from the bottom
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TERM: StreamBuilder - Widget that rebuilds when stream emits new values
    // WHAT IT DOES: Automatically updates UI when the current song changes
    return StreamBuilder<Song?>(
      // TERM: Stream - A sequence of events/data over time (like a river of data)
      // TERM: Stream.periodic - Emits events at regular intervals
      // WHAT IT DOES: Check for song changes every 100 milliseconds
      stream: Stream.periodic(const Duration(milliseconds: 100))
          .map((_) => _audioService.currentSong),  // Get current song each time
      // TERM: builder - Function that builds the UI with the latest data
      builder: (context, snapshot) {
        // TERM: snapshot - Contains the latest data from the stream
        final currentSong = snapshot.data;
        // TERM: SizedBox.shrink() - An invisible widget with zero size
        // If no song is playing, don't show the player (return invisible widget)
        if (currentSong == null) return const SizedBox.shrink();

        return GestureDetector(
          onTap: _openPlayer,
          child: Container(
            height: 60,
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFF282828),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                children: [
                  // Progress bar at bottom
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: StreamBuilder<Duration>(
                      stream: _audioService.positionStream,
                      builder: (context, posSnapshot) {
                        return StreamBuilder<Duration?>(
                          stream: _audioService.durationStream,
                          builder: (context, durSnapshot) {
                            final position = posSnapshot.data ?? Duration.zero;
                            final duration =
                                durSnapshot.data ?? const Duration(seconds: 1);
                            final progress = duration.inMilliseconds > 0
                                ? position.inMilliseconds /
                                    duration.inMilliseconds
                                : 0.0;

                            return LinearProgressIndicator(
                              value: progress,
                              backgroundColor: Colors.transparent,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).colorScheme.primary,
                              ),
                              minHeight: 2,
                            );
                          },
                        );
                      },
                    ),
                  ),
                  // Player content
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Row(
                      children: [
                        // Album art
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Icon(
                            Icons.music_note,
                            color: Colors.white54,
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Song info
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                currentSong.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                currentSong.artist,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey[400],
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        // Controls
                        IconButton(
                          icon: const Icon(Icons.favorite_border),
                          iconSize: 20,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(
                            minWidth: 40,
                            minHeight: 40,
                          ),
                          onPressed: () {},
                        ),
                        StreamBuilder<bool>(
                          stream: _audioService.playingStream,
                          builder: (context, playingSnapshot) {
                            final isPlaying = playingSnapshot.data ?? false;
                            return IconButton(
                              icon: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow,
                                size: 26,
                              ),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(
                                minWidth: 40,
                                minHeight: 40,
                              ),
                              onPressed: _audioService.togglePlayPause,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
