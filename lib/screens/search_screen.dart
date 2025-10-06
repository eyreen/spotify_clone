// Import Flutter widgets
import 'package:flutter/material.dart';
// Import sample data
import '../data/mock_data.dart';
// Import data models
import '../models/song.dart';
import '../models/playlist.dart';

// WHAT IT DOES: This is the search screen (second tab) where users can search for songs
// TERM: StatefulWidget - Can change over time (search results update as user types)
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

// This class holds the changing data (state) for the search screen
class _SearchScreenState extends State<SearchScreen> {
  // TERM: TextEditingController - Controls and monitors text input in a text field
  // WHAT IT DOES: Tracks what the user types in the search box
  final TextEditingController _searchController = TextEditingController();

  // WHAT IT DOES: Stores the list of songs that match the search
  List<Song> _searchResults = [];

  // WHAT IT DOES: Tracks whether user is currently searching (typed something)
  bool _isSearching = false;

  // TERM: dispose() - Cleanup method called when widget is removed from the widget tree
  // WHAT IT DOES: Prevents memory leaks by cleaning up the controller
  @override
  void dispose() {
    _searchController.dispose();  // Free up memory used by the controller
    super.dispose();
  }

  // WHAT IT DOES: Searches through all songs and finds matches
  // TERM: void - This function doesn't return anything
  void _performSearch(String query) {
    // TERM: setState() - Tells Flutter to rebuild the UI with new data
    setState(() {
      // TERM: isNotEmpty - Returns true if string has at least one character
      _isSearching = query.isNotEmpty;

      if (query.isEmpty) {
        // If search box is empty, clear results
        _searchResults = [];
      } else {
        // TERM: .where() - Filters a list based on a condition
        // TERM: .toLowerCase() - Converts text to lowercase for case-insensitive search
        // TERM: .contains() - Checks if string contains another string
        // WHAT IT DOES: Find songs where title, artist, OR album contains the search text
        _searchResults = MockData.songs.where((song) {
          return song.title.toLowerCase().contains(query.toLowerCase()) ||
              song.artist.toLowerCase().contains(query.toLowerCase()) ||
              song.album.toLowerCase().contains(query.toLowerCase());
        }).toList();  // TERM: .toList() - Converts filtered results back to a list
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchBar(),
            Expanded(
              child: _isSearching
                  ? _buildSearchResults()
                  : _buildBrowseCategories(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _searchController,
        onChanged: _performSearch,
        decoration: InputDecoration(
          hintText: 'What do you want to listen to?',
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.grey),
                  onPressed: () {
                    _searchController.clear();
                    _performSearch('');
                  },
                )
              : null,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
        style: const TextStyle(color: Colors.black),
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_searchResults.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No results found',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 140), // Space for bottom player
      child: ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          final song = _searchResults[index];
          return _buildSongItem(song);
        },
      ),
    );
  }

  Widget _buildSongItem(Song song) {
    return ListTile(
      leading: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Icon(Icons.music_note, color: Colors.white54),
      ),
      title: Text(
        song.title,
        style: const TextStyle(fontWeight: FontWeight.w500),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        song.artist,
        style: TextStyle(color: Colors.grey[400]),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: IconButton(
        icon: const Icon(Icons.more_vert),
        onPressed: () {
          // Show options menu
        },
      ),
      onTap: () {
        // Play song
      },
    );
  }

  Widget _buildBrowseCategories() {
    final categories = [
      {'name': 'Pop', 'color': Colors.pink[300]!},
      {'name': 'Hip-Hop', 'color': Colors.purple[400]!},
      {'name': 'Rock', 'color': Colors.orange[400]!},
      {'name': 'Latin', 'color': Colors.red[300]!},
      {'name': 'Podcasts', 'color': Colors.green[400]!},
      {'name': 'Charts', 'color': Colors.blue[400]!},
      {'name': 'Country', 'color': Colors.brown[300]!},
      {'name': 'R&B', 'color': Colors.indigo[300]!},
    ];

    return Padding(
      padding: const EdgeInsets.only(bottom: 140), // Space for bottom player
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Browse all',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return _buildCategoryCard(
                  category['name'] as String,
                  category['color'] as Color,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String name, Color color) {
    return InkWell(
      onTap: () {
        // Navigate to category
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 12,
              left: 12,
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Transform.rotate(
                angle: 0.3,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.music_note,
                    color: Colors.white54,
                    size: 40,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
