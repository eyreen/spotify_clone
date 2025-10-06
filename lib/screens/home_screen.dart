// Import Flutter's material design widgets
import 'package:flutter/material.dart';
// Import fake/sample data for testing
import '../data/mock_data.dart';
// Import our data models
import '../models/playlist.dart';
import '../models/album.dart';
// Import the detail screen to navigate to
import 'playlist_detail_screen.dart';

// WHAT IT DOES: This is the home screen (first tab) that shows playlists and albums
// TERM: StatelessWidget - Doesn't change after it's built
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TERM: Scaffold - Basic screen structure with app bar, body, etc.
    return Scaffold(
      body: SafeArea(  // TERM: SafeArea - Avoids system UI (notch, status bar, etc.)
        // TERM: SingleChildScrollView - Makes content scrollable if it's too tall
        child: SingleChildScrollView(
          // WHAT IT DOES: Add space at bottom so the music player doesn't cover content
          padding: const EdgeInsets.only(bottom: 140),
          // TERM: Column - Stack widgets vertically (top to bottom)
          child: Column(
            // WHAT IT DOES: Align children to the start (left side for English)
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Show greeting message based on time of day
              _buildGreeting(context),
              const SizedBox(height: 16),  // TERM: SizedBox - Empty space/padding
              // Show recently played items in a grid
              _buildRecentlyPlayed(),
              const SizedBox(height: 24),
              // Show a section with horizontal scrolling playlists
              _buildSection(
                context,
                'Your top mixes',           // Section title
                MockData.playlists,         // Data to display
              ),
              const SizedBox(height: 24),
              // Show albums section
              _buildSection(
                context,
                'Popular albums',
                MockData.albums,
              ),
              const SizedBox(height: 24),
              // Show recommended playlists (same data but reversed)
              _buildSection(
                context,
                'Recommended playlists',
                MockData.playlists.reversed.toList(),  // TERM: reversed - Flip the list order
              ),
            ],
          ),
        ),
      ),
    );
  }

  // WHAT IT DOES: Builds the greeting message that changes based on time of day
  // TERM: Private method (starts with _) - Only used inside this file
  Widget _buildGreeting(BuildContext context) {
    // TERM: DateTime.now() - Gets the current date and time
    // TERM: .hour - Gets the hour (0-23) from the current time
    final hour = DateTime.now().hour;

    // Start with evening greeting as default
    String greeting = 'Good evening';

    // TERM: if - Conditional statement (do something IF condition is true)
    // If it's before noon (12 PM), show morning greeting
    if (hour < 12) greeting = 'Good morning';
    // TERM: else if - Check another condition if the first one was false
    // If it's before 6 PM, show afternoon greeting
    else if (hour < 18) greeting = 'Good afternoon';

    // TERM: Padding - Adds space around a widget
    return Padding(
      // TERM: EdgeInsets.all(16) - Add 16 pixels of space on all sides
      padding: const EdgeInsets.all(16),
      // TERM: Text - Widget that displays text
      child: Text(
        greeting,  // The text to display
        // TERM: style - Defines how the text looks
        style: const TextStyle(
          fontSize: 28,                      // Large text (28 pixels)
          fontWeight: FontWeight.bold,       // Bold text
        ),
      ),
    );
  }

  // WHAT IT DOES: Builds a 2-column grid of recently played items
  Widget _buildRecentlyPlayed() {
    return Padding(
      // TERM: EdgeInsets.symmetric - Add same padding on opposite sides
      padding: const EdgeInsets.symmetric(horizontal: 16),  // Left & right padding
      // TERM: GridView.builder - Creates a grid layout efficiently (only builds visible items)
      child: GridView.builder(
        // TERM: shrinkWrap - Grid only takes space it needs (doesn't expand to fill screen)
        shrinkWrap: true,
        // TERM: NeverScrollableScrollPhysics - Disables scrolling (parent ScrollView handles it)
        physics: const NeverScrollableScrollPhysics(),
        // TERM: gridDelegate - Defines how the grid is laid out
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,          // 2 columns
          childAspectRatio: 3,        // Width is 3x the height (makes rectangles)
          crossAxisSpacing: 8,        // 8 pixels space between columns
          mainAxisSpacing: 8,         // 8 pixels space between rows
        ),
        itemCount: 6,  // Show 6 items total
        // TERM: itemBuilder - Function that builds each item in the grid
        // Called once for each item (index 0 to 5)
        itemBuilder: (context, index) {
          // TERM: % (modulo) - Gets remainder after division, wraps index if exceeds list length
          final playlist = MockData.playlists[index % MockData.playlists.length];
          return _buildRecentItem(context, playlist);
        },
      ),
    );
  }

  // WHAT IT DOES: Builds one rectangular item for the recently played grid
  Widget _buildRecentItem(BuildContext context, Playlist playlist) {
    // TERM: InkWell - Makes a widget tappable with ripple effect
    return InkWell(
      // TERM: onTap - Function that runs when user taps this widget
      onTap: () {
        // TERM: Navigator.push - Navigate to a new screen
        // Think of it like opening a new page on top of the current one
        Navigator.push(
          context,
          // TERM: MaterialPageRoute - Defines the transition animation to the new screen
          MaterialPageRoute(
            // TERM: builder - Function that creates the new screen
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
