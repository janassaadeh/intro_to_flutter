import 'package:flutter/material.dart';
import 'package:intro_to_flutter/Provider/user_provider.dart';
import 'package:intro_to_flutter/Screens/home_layout.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';



void main()async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyC6pwg2u3prtWWcYF7iyJMNmBNzISNOIMM",
      appId: "1:279812721287:android:5cac8f8518bfb4677e4622",
      messagingSenderId: "279812721287",
      projectId: "fir-test-3bdbb",
    )
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const HomeLayout(
        index: 0,
      ),
    );
  }
}
