import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/cart_provider.dart';
import './screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => CartProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Kopi App',
        theme: ThemeData(
          primarySwatch: Colors.brown,
          fontFamily: 'Roboto',
        ),
        home: const WelcomeScreen(), 
      ),
    );
  }
}