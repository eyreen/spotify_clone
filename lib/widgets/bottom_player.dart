import 'package:flutter/material.dart';
import '../models/song.dart';
import '../screens/player_screen.dart';
import '../services/audio_player_service.dart';

class BottomPlayer extends StatefulWidget {
  const BottomPlayer({super.key});

  @override
  State<BottomPlayer> createState() => _BottomPlayerState();
}

class _BottomPlayerState extends State<BottomPlayer> {
  final AudioPlayerService _audioService = AudioPlayerService();

  @override
  void dispose() {
    super.dispose();
  }

  void _openPlayer() {
    if (_audioService.currentSong != null) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              PlayerScreen(song: _audioService.currentSong!),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );
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
    return StreamBuilder<Song?>(
      stream: Stream.periodic(const Duration(milliseconds: 100))
          .map((_) => _audioService.currentSong),
      builder: (context, snapshot) {
        final currentSong = snapshot.data;
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
