import 'package:flutter/material.dart';
import 'package:flutter_foods/providers/users_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UsersProvider>(context);

    return const Scaffold(
      body: Center(
        child: Text('Hello World!'),
      ),
    );
  }
}
