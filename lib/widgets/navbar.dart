import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final List<Widget> pages;
  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);

  NavBar({super.key, required this.pages});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _selectedIndex,
      builder: (context, value, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: pages[value],
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _selectedIndex.value = 1; 
            },
            backgroundColor: Colors.purple[300],
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 5.0,
            child: SizedBox(
              height: 60,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: IconButton(
                      iconSize: 30.0,
                      icon: const Icon(Icons.home),
                      onPressed: () {
                        _selectedIndex.value = 0;
                      },
                    ),
                  ),
                  const Expanded(
                    child: SizedBox.shrink(), // Empty space for the floating action button
                  ),
                  Expanded(
                    child: IconButton(
                      iconSize: 30.0,
                      icon: const Icon(Icons.person),
                      onPressed: () {
                        _selectedIndex.value = 2;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
