import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/playlist.dart';
import '../models/album.dart';
import 'playlist_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 140), // Space for bottom player
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGreeting(context),
              const SizedBox(height: 16),
              _buildRecentlyPlayed(),
              const SizedBox(height: 24),
              _buildSection(
                context,
                'Your top mixes',
                MockData.playlists,
              ),
              const SizedBox(height: 24),
              _buildSection(
                context,
                'Popular albums',
                MockData.albums,
              ),
              const SizedBox(height: 24),
              _buildSection(
                context,
                'Recommended playlists',
                MockData.playlists.reversed.toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGreeting(BuildContext context) {
    final hour = DateTime.now().hour;
    String greeting = 'Good evening';
    if (hour < 12) greeting = 'Good morning';
    else if (hour < 18) greeting = 'Good afternoon';

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        greeting,
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildRecentlyPlayed() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          final playlist = MockData.playlists[index % MockData.playlists.length];
          return _buildRecentItem(context, playlist);
        },
      ),
    );
  }

  Widget _buildRecentItem(BuildContext context, Playlist playlist) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlaylistDetailScreen(playlist: playlist),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(4),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Row(
            children: [
              Container(
                width: 56,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                ),
                child: const AspectRatio(
                  aspectRatio: 1,
                  child: Icon(Icons.music_note, color: Colors.white54),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    playlist.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<dynamic> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 210,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return _buildCard(context, item);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCard(BuildContext context, dynamic item) {
    String title = '';
    String subtitle = '';
    String imageUrl = '';

    if (item is Playlist) {
      title = item.name;
      subtitle = item.description;
      imageUrl = item.coverUrl;
    } else if (item is Album) {
      title = item.name;
      subtitle = item.artist;
      imageUrl = item.coverUrl;
    }

    return GestureDetector(
      onTap: () {
        if (item is Playlist) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlaylistDetailScreen(playlist: item),
            ),
          );
        }
      },
      child: Container(
        width: 150,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.album, color: Colors.white54, size: 60),
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                height: 1.2,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Flexible(
              child: Text(
                subtitle,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[400],
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
