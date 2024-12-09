import 'package:flutter/material.dart';
import 'package:tasteofbandung/core/bases/widgets/_widgets.dart';
import 'package:tasteofbandung/features/bookmark/bookmark_page.dart';
import 'package:tasteofbandung/features/home/home_page.dart';
import 'features/profile/presentation/pages/_pages.dart';
import 'features/search/presentation/pages/_pages.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Features> _features = [
    Features(widget: const HomePage(), icon: Icons.home, text: "Home"),
    Features(widget: const SearchPage(), icon: Icons.search, text: "Search"),
    Features(widget: const BookmarkPage(), icon: Icons.book, text: "Bookmark"),
    Features(widget: const ProfilePage(), icon: Icons.person, text: "Profile"),
  ];
  late Features _selectedFeauture;
  
  @override
  void initState() {
    _selectedFeauture = _features[0];
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }

  void setSelectedFeature(Features newSelectedFeature) {
    if (_selectedFeauture != newSelectedFeature) {
      setState(() {
        _selectedFeauture = newSelectedFeature;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: _selectedFeauture.widget,
          ),
          TobBottomNavigationBar(
            features: _features, 
            selectedFeauture: _selectedFeauture, 
            onTap: setSelectedFeature
          )
        ],
      ),
    );
  }
}