import 'package:flutter/material.dart';
import 'package:flutter_foods/core/constants/api.dart';
import 'package:flutter_foods/providers/users_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = Provider.of<UsersProvider>(context, listen: false);
      userProvider.fetchAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UsersProvider>(context);

    return Scaffold(
      body: Center(
        child: userProvider.isLoading
            ? const CircularProgressIndicator()
            : userProvider.hasError
                ? Text('Error: ${userProvider.errorMessage}')
                : Text('Total Users: ${userProvider.users.length}'),
      ),
    );
  }
}
