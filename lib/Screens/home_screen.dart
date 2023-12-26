import 'package:flutter/material.dart';
import 'package:intro_to_flutter/Provider/user_provider.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: true);


    return Center(
      child: Text(userProvider.isLogged?'Logged in!':'Logged out!'),
    );
  }
}
