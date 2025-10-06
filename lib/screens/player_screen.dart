import 'package:flutter/material.dart';
import '../models/song.dart';

class PlayerScreen extends StatefulWidget {
  final Song song;

  const PlayerScreen({super.key, required this.song});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  bool _isPlaying = true;
  bool _isShuffle = false;
  bool _isRepeat = false;
  double _currentPosition = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.purple.shade900,
              Colors.black,
              Colors.black,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(),
              const Spacer(),
              _buildAlbumArt(),
              const Spacer(),
              _buildSongInfo(),
              const SizedBox(height: 32),
              _buildProgressBar(),
              const SizedBox(height: 32),
              _buildControls(),
              const SizedBox(height: 16),
              _buildSecondaryControls(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.keyboard_arrow_down),
            iconSize: 32,
            onPressed: () => Navigator.pop(context),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'PLAYING FROM PLAYLIST',
                style: TextStyle(fontSize: 10, color: Colors.white70),
              ),
              Text(
                widget.song.album,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildAlbumArt() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(
            Icons.album,
            color: Colors.white30,
            size: 120,
          ),
        ),
      ),
    );
  }

  Widget _buildSongInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.song.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  widget.song.artist,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[400],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border),
            iconSize: 28,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 3,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
            ),
            child: Slider(
              value: _currentPosition,
              max: widget.song.duration.inSeconds.toDouble(),
              activeColor: Colors.white,
              inactiveColor: Colors.grey[700],
              onChanged: (value) {
                setState(() => _currentPosition = value);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDuration(Duration(seconds: _currentPosition.toInt())),
                  style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                ),
                Text(
                  _formatDuration(widget.song.duration),
                  style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(
              _isShuffle ? Icons.shuffle_on_outlined : Icons.shuffle,
              color: _isShuffle ? Theme.of(context).colorScheme.primary : Colors.white,
            ),
            iconSize: 28,
            onPressed: () {
              setState(() => _isShuffle = !_isShuffle);
            },
          ),
          IconButton(
            icon: const Icon(Icons.skip_previous),
            iconSize: 40,
            onPressed: () {},
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                _isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.black,
              ),
              iconSize: 40,
              onPressed: () {
                setState(() => _isPlaying = !_isPlaying);
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.skip_next),
            iconSize: 40,
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              _isRepeat ? Icons.repeat_one : Icons.repeat,
              color: _isRepeat ? Theme.of(context).colorScheme.primary : Colors.white,
            ),
            iconSize: 28,
            onPressed: () {
              setState(() => _isRepeat = !_isRepeat);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSecondaryControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.devices),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.queue_music),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
