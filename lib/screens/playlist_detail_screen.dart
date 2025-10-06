import 'package:flutter/material.dart';
import '../models/playlist.dart';
import '../models/song.dart';
import 'player_screen.dart';

class PlaylistDetailScreen extends StatefulWidget {
  final Playlist playlist;

  const PlaylistDetailScreen({super.key, required this.playlist});

  @override
  State<PlaylistDetailScreen> createState() => _PlaylistDetailScreenState();
}

class _PlaylistDetailScreenState extends State<PlaylistDetailScreen> {
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final opacity = (_scrollOffset / 200).clamp(0.0, 1.0);

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                expandedHeight: 350,
                pinned: true,
                backgroundColor: Colors.black.withOpacity(opacity),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.purple.shade800,
                          Colors.purple.shade900,
                          Colors.black,
                        ],
                      ),
                    ),
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _buildPlaylistHeader(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.purple.shade900.withOpacity(0.3),
                        Colors.black,
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      _buildControls(),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index < widget.playlist.songs.length) {
                      return _buildSongItem(
                        widget.playlist.songs[index],
                        index,
                      );
                    }
                    return const SizedBox(height: 140); // Bottom padding
                  },
                  childCount: widget.playlist.songs.length + 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlaylistHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Playlist cover
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[800],
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
              Icons.library_music,
              color: Colors.white54,
              size: 80,
            ),
          ),
          const SizedBox(height: 24),
          // Playlist name
          Text(
            widget.playlist.name,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          // Description
          if (widget.playlist.description.isNotEmpty)
            Text(
              widget.playlist.description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[400],
              ),
              textAlign: TextAlign.center,
            ),
          const SizedBox(height: 12),
          // Stats
          Text(
            '${widget.playlist.songs.length} songs',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            iconSize: 32,
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.download_outlined),
            iconSize: 32,
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            iconSize: 32,
            onPressed: () {},
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.shuffle),
            iconSize: 28,
            color: Colors.grey[400],
            onPressed: () {},
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            onPressed: () {
              // Play first song
              if (widget.playlist.songs.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PlayerScreen(song: widget.playlist.songs.first),
                  ),
                );
              }
            },
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: const Icon(Icons.play_arrow, color: Colors.black, size: 32),
          ),
        ],
      ),
    );
  }

  Widget _buildSongItem(Song song, int index) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: SizedBox(
        width: 40,
        child: Center(
          child: Text(
            '${index + 1}',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 16,
            ),
          ),
        ),
      ),
      title: Text(
        song.title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        song.artist,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[400],
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: IconButton(
        icon: const Icon(Icons.more_vert),
        color: Colors.grey[400],
        onPressed: () {},
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlayerScreen(song: song),
          ),
        );
      },
    );
  }
}
