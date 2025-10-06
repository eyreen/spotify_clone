// TERM: import - This brings in code from other files/packages so we can use them
// This imports Flutter's material design widgets (buttons, text, colors, etc.)
import 'package:flutter/material.dart';
// These import our custom screens that we built
import 'screens/home_screen.dart';
import 'screens/search_screen.dart';
import 'screens/library_screen.dart';
// This imports the mini player widget at the bottom of the screen
import 'widgets/bottom_player.dart';

// TERM: main() - The starting point of every Flutter app. This function runs first when the app launches
void main() {
  // TERM: runApp() - This function tells Flutter to start the app and display our widget tree
  // TERM: const - Means this value never changes (makes app faster and uses less memory)
  runApp(const SpotifyCloneApp());
}

// TERM: class - A blueprint/template for creating objects (like a cookie cutter)
// TERM: extends - Means this class inherits features from another class (StatelessWidget)
// TERM: StatelessWidget - A widget that doesn't change once it's built (no animation, no user interaction changing it)
class SpotifyCloneApp extends StatelessWidget {
  // TERM: const constructor - Creates an unchanging instance of the class
  // TERM: super.key - Passes the key to the parent class (StatelessWidget) for Flutter's internal tracking
  const SpotifyCloneApp({super.key});

  // TERM: @override - Tells Dart we're replacing a method from the parent class
  // TERM: Widget - The basic building block of Flutter UI (everything you see is a widget)
  // TERM: build() - This method creates and returns the UI for this widget
  // TERM: BuildContext - Contains information about where this widget is in the widget tree
  @override
  Widget build(BuildContext context) {
    // TERM: return - Sends back the result (in this case, our app's UI)
    // TERM: MaterialApp - The root widget that provides Material Design features to the whole app
    return MaterialApp(
      // WHAT IT DOES: Sets the app name (shows in task manager, not on screen)
      title: 'Spotify Clone',
      // WHAT IT DOES: Hides the "DEBUG" banner in the top-right corner
      debugShowCheckedModeBanner: false,
      // TERM: theme - Defines the colors, fonts, and styles for the entire app
      // TERM: ThemeData - A collection of colors and styles Flutter uses throughout the app
      theme: ThemeData(
        // WHAT IT DOES: Sets the app to dark mode
        brightness: Brightness.dark,
        // WHAT IT DOES: Sets the main app color (Spotify green: #1DB954)
        // TERM: Color(0xFF______) - Creates a color from hex code (0xFF means fully opaque)
        primaryColor: const Color(0xFF1DB954),
        // WHAT IT DOES: Sets the background color for all screens (very dark gray)
        scaffoldBackgroundColor: const Color(0xFF121212),
        // TERM: colorScheme - A set of colors that work well together
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF1DB954),      // Main accent color (Spotify green)
          secondary: Color(0xFF1DB954),    // Secondary accent color
          surface: Color(0xFF181818),      // Color for cards, containers, etc.
        ),
        // TERM: appBarTheme - Styling for the top bar of screens
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF121212), // Top bar background color
          elevation: 0,                        // No shadow under the top bar
        ),
        // TERM: bottomNavigationBarTheme - Styling for the bottom navigation bar
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF181818),      // Bottom bar background
          selectedItemColor: Color(0xFF1DB954),    // Color when tab is selected (green)
          unselectedItemColor: Colors.grey,        // Color when tab is not selected (gray)
          type: BottomNavigationBarType.fixed,     // Keeps icons fixed in place (no animation)
        ),
      ),
      // WHAT IT DOES: Sets the first screen to show when the app opens
      home: const MainScreen(),
    );
  }
}

// TERM: StatefulWidget - A widget that CAN change over time (has animation, responds to user input)
// This is the main container that holds all our screens and the bottom navigation
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  // TERM: createState() - Creates the State object that holds the changing data for this widget
  // TERM: State<MainScreen> - The object that stores data that can change (like which tab is selected)
  @override
  State<MainScreen> createState() => _MainScreenState();
}

// TERM: _MainScreenState - The underscore (_) means this class is private (only used in this file)
// This class contains all the logic and data that can change in MainScreen
class _MainScreenState extends State<MainScreen> {
  // TERM: int - Integer (whole number) data type
  // WHAT IT DOES: Tracks which tab is currently selected (0 = Home, 1 = Search, 2 = Library)
  // The underscore (_) means this is a private variable
  int _selectedIndex = 0;

  // TERM: final - This variable can only be set once and never changes after that
  // TERM: List<Widget> - A list (array) that can hold multiple widgets
  // WHAT IT DOES: Stores all three screens so we can switch between them
  final List<Widget> _screens = [
    const HomeScreen(),      // Index 0 - Home screen
    const SearchScreen(),    // Index 1 - Search screen
    const LibraryScreen(),   // Index 2 - Library screen
  ];

  @override
  Widget build(BuildContext context) {
    // TERM: Scaffold - A basic screen structure with app bar, body, bottom navigation, etc.
    return Scaffold(
      // TERM: body - The main content area of the screen
      // TERM: Stack - Layers widgets on top of each other (like stacking papers)
      body: Stack(
        children: [
          // TERM: IndexedStack - Shows only ONE child widget at a time based on the index
          // WHAT IT DOES: Displays the selected screen while keeping other screens in memory
          // (This makes switching between tabs instant - no reloading)
          IndexedStack(
            index: _selectedIndex,  // Which screen to show (0, 1, or 2)
            children: _screens,     // The list of all screens
          ),
          // TERM: Positioned - Places a widget at a specific position within a Stack
          // WHAT IT DOES: Puts the music player at the bottom of the screen
          Positioned(
            bottom: 0,   // 0 pixels from the bottom
            left: 0,     // 0 pixels from the left (full width)
            right: 0,    // 0 pixels from the right (full width)
            // TERM: Column - Arranges widgets vertically (top to bottom)
            child: Column(
              // WHAT IT DOES: Column only takes up the minimum space it needs
              mainAxisSize: MainAxisSize.min,
              children: const [
                BottomPlayer(),                // The mini music player widget
                SizedBox(height: 60),          // Empty space to push player above bottom nav
              ],
            ),
          ),
        ],
      ),
      // TERM: bottomNavigationBar - The navigation bar at the bottom with tabs
      bottomNavigationBar: BottomNavigationBar(
        // WHAT IT DOES: Highlights the currently selected tab
        currentIndex: _selectedIndex,
        // TERM: onTap - Function that runs when user taps a tab
        // TERM: setState() - Tells Flutter to rebuild the widget with new data
        // WHAT IT DOES: When user taps a tab, update _selectedIndex and rebuild the screen
        onTap: (index) => setState(() => _selectedIndex = index),
        // TERM: items - The list of tabs to show in the bottom navigation
        items: const [
          // Each BottomNavigationBarItem is one tab
          BottomNavigationBarItem(
            icon: Icon(Icons.home),        // The home icon
            label: 'Home',                 // Text under the icon
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),      // The search icon
            label: 'Search',               // Text under the icon
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music), // The library icon
            label: 'Your Library',           // Text under the icon
          ),
        ],
      ),
    );
  }
}
