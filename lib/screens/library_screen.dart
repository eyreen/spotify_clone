// Import Flutter widgets
import 'package:flutter/material.dart';
// Import sample data
import '../data/mock_data.dart';
// Import data models
import '../models/playlist.dart';
// Import detail screen
import 'playlist_detail_screen.dart';

// WHAT IT DOES: This is the library screen (third tab) that shows user's saved music
// Has 3 tabs: Playlists, Albums, Artists
class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

// TERM: with SingleTickerProviderStateMixin - Provides animation support for tabs
// WHAT IT DOES: Required for TabController to animate tab transitions smoothly
class _LibraryScreenState extends State<LibraryScreen>
    with SingleTickerProviderStateMixin {
  // TERM: late - Variable will be initialized later (before being used)
  // TERM: TabController - Controls which tab is active and handles tab switching
  late TabController _tabController;

  // TERM: initState() - Called once when widget is created (like a constructor)
  // WHAT IT DOES: Sets up the tab controller when screen loads
  @override
  void initState() {
    super.initState();
    // Create tab controller with 3 tabs
    // TERM: vsync - Synchronizes animation with screen refresh rate for smooth transitions
    _tabController = TabController(length: 3, vsync: this);
  }

  // TERM: dispose() - Cleanup method called when widget is removed
  // WHAT IT DOES: Prevents memory leaks by cleaning up the tab controller
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildTabs(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildPlaylistsTab(),
                  _buildAlbumsTab(),
                  _buildArtistsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundColor: Colors.purple,
            child: Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 12),
          const Text(
            'Your Library',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Show create playlist dialog
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return TabBar(
      controller: _tabController,
      indicatorColor: Theme.of(context).colorScheme.primary,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.grey,
      tabs: const [
        Tab(text: 'Playlists'),
        Tab(text: 'Albums'),
        Tab(text: 'Artists'),
      ],
    );
  }

  Widget _buildPlaylistsTab() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 140), // Space for bottom player
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: MockData.playlists.length,
        itemBuilder: (context, index) {
          final playlist = MockData.playlists[index];
          return _buildPlaylistItem(playlist);
        },
      ),
    );
  }

  Widget _buildPlaylistItem(Playlist playlist) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Icon(Icons.library_music, color: Colors.white54, size: 32),
      ),
      title: Text(
        playlist.name,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        '${playlist.songs.length} songs',
        style: TextStyle(color: Colors.grey[400]),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlaylistDetailScreen(playlist: playlist),
          ),
        );
      },
    );
  }

  Widget _buildAlbumsTab() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 140), // Space for bottom player
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: MockData.albums.length,
        itemBuilder: (context, index) {
          final album = MockData.albums[index];
          return ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(Icons.album, color: Colors.white54, size: 32),
            ),
            title: Text(
              album.name,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              album.artist,
              style: TextStyle(color: Colors.grey[400]),
            ),
            onTap: () {
              // Navigate to album detail
            },
          );
        },
      ),
    );
  }

  Widget _buildArtistsTab() {
    final artists = ['The Weeknd', 'Dua Lipa', 'Justin Bieber', 'Olivia Rodrigo'];

    return Padding(
      padding: const EdgeInsets.only(bottom: 140), // Space for bottom player
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: artists.length,
        itemBuilder: (context, index) {
          final artist = artists[index];
          return ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: CircleAvatar(
              radius: 32,
              backgroundColor: Colors.grey[800],
              child: const Icon(Icons.person, color: Colors.white54, size: 32),
            ),
            title: Text(
              artist,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              'Artist',
              style: TextStyle(color: Colors.grey[400]),
            ),
            onTap: () {
              // Navigate to artist page
            },
          );
        },
      ),
    );
  }
}
