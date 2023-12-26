import 'package:flutter/material.dart';
import 'package:intro_to_flutter/Screens/home_screen.dart';
import 'package:intro_to_flutter/Screens/user_screen.dart';
import 'package:intro_to_flutter/Provider/user_provider.dart';
import 'package:provider/provider.dart';

class HomeLayout extends StatefulWidget {
  final int index;
  const HomeLayout({super.key, required this.index});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const UserScreen(),
  ];

  @override
  void initState() {
    super.initState();
    currentIndex = widget.index;
    print(currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.logo_dev),
        title: const Text(
          'Home',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.amber,
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User',
          ),
        ],
      ),
    );
  }
}
