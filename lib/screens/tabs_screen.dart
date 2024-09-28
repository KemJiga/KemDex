import 'package:flutter/material.dart';
import 'package:manga_kemdex/screens/home_page.dart';
import 'package:manga_kemdex/screens/manga_page.dart';
import 'package:manga_kemdex/screens/search_manga.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var activePageName = const [
      'Home',
      'Search',
      'Shelf',
    ];
    Widget? activePage;

    switch (_selectedPageIndex) {
      case 0:
        activePage = HomeScreen();
      case 1:
        activePage = SearchMangaScreen();
      case 2:
        activePage = MangaPageScreen();
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.075,
        //backgroundColor: Theme.of(context).colorScheme.primary,
        title: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Manga Kemdex',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                activePageName[_selectedPageIndex],
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        child: activePage,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shelves),
            label: 'Shelf',
          ),
        ],
      ),
    );
  }
}
