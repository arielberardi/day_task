import 'package:day_task/components/bottom_app_navigation_bar.dart';
import 'package:day_task/pages/home_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _pageController = PageController();
  final List<Widget> _pages = [
    const HomePage(),
    const Text('Chat'),
    const Text('New Task'),
    const Text('Calendar'),
    const Text('Notification'),
  ];

  int _currentPage = 0;

  void onPageChanged(BuildContext context, int value) {
    setState(() => _currentPage = value);

    _pageController.animateToPage(
      value,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeIn,
    );
  }

  Widget getBottomNavigationBar(BuildContext context) {
    if (_currentPage == 2) {
      return Container();
    }

    return BottomAppNavigationBar(
      onChange: (value) => onPageChanged(context, value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: PageView(
        controller: _pageController,
        children: _pages,
      ),
      bottomNavigationBar: getBottomNavigationBar(context),
    );
  }
}
