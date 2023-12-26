import 'package:flutter/material.dart';
import 'package:intro_to_flutter/Provider/user_provider.dart';
import 'package:intro_to_flutter/Screens/login_screen.dart';
import 'package:intro_to_flutter/Screens/home_screen.dart';

import 'package:intro_to_flutter/Screens/profile_screen.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: true);
    
    print(userProvider.isLogged);
    return userProvider.isLogged ? const ProfileScreen() : const LoginScreen();

  }}
