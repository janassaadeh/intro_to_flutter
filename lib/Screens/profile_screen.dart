import 'package:flutter/material.dart';
import 'package:intro_to_flutter/Provider/user_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: true);

    // Check if userModel is not null before accessing its properties
    final String userName = userProvider.userModel?.name ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text('Name:'),
                const SizedBox(
                  width: 2,
                ),
                Text(userName),
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            GestureDetector(
              onTap: () {
                userProvider.logout();
              },
              child: Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                child: const Text(
                  'Logout',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
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
