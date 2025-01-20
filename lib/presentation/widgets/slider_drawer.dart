import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_foods/data/models/auth_credential.dart';
import 'package:flutter_foods/presentation/screens/choose_address_screen.dart';
import 'package:flutter_foods/providers/auth_provider.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SliderDrawerWidget extends StatefulWidget {
  const SliderDrawerWidget({super.key});

  @override
  State<SliderDrawerWidget> createState() => _SliderDrawerWidgetState();
}

class _SliderDrawerWidgetState extends State<SliderDrawerWidget> {
  late String token = '';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? credentialJson = prefs.getString('credential');
        AuthCredential authCredential =
            AuthCredential.fromJson(jsonDecode(credentialJson!));

        setState(() {
          token = authCredential.token;
        });
      } catch (error) {
        print("Error fetching addresses: $error");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return FutureBuilder(
            future: authProvider.initialize(),
            builder: (context, snapshot) {
              final authCredential = authProvider.authCredential;
              final isLogged = authProvider.isAuthenticated;

              return ListView(padding: EdgeInsets.zero, children: <Widget>[
                DrawerHeader(
                  decoration: const BoxDecoration(),
                  child: isLogged
                      ? Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                authCredential?.avatar ??
                                    'https://via.placeholder.com/150',
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  authCredential?.username ?? 'John Doe',
                                  style: const TextStyle(fontSize: 20),
                                  softWrap: true,
                                ),
                                Text(
                                  authCredential?.userEmail ?? 'test@gmail.com',
                                  style: const TextStyle(fontSize: 14),
                                  softWrap: true,
                                ),
                              ],
                            ),
                          ],
                        )
                      : Text(
                          'Xin chào khách hàng',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 20,
                            fontFamily: GoogleFonts.ibmPlexSans().fontFamily,
                          ),
                        ),
                ),
                ListTile(
                  leading: isLogged
                      ? const Icon(TablerIcons.logout)
                      : const Icon(TablerIcons.login),
                  title: Text(isLogged ? 'Đăng xuất' : 'Đăng nhập'),
                  onTap: () {
                    Navigator.pop(context);
                    if (isLogged) {
                      authProvider.logout();
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/login', (route) => false);
                    } else {
                      Navigator.pushNamed(context, '/login');
                    }
                  },
                ),
                if (token.isNotEmpty)
                  ListTile(
                    leading: const Icon(TablerIcons.address_book),
                    title: const Text('Địa chỉ'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ChooseAddressScreen(),
                        ),
                      );
                    },
                  ),
                if (token.isNotEmpty)
                  ListTile(
                    leading: const Icon(TablerIcons.shopping_cart),
                    title: const Text('Giỏ hàng'),
                    onTap: () {
                      Navigator.pushNamed(context, '/cart');
                    },
                  ),
                if (token.isNotEmpty)
                  ListTile(
                    leading: const Icon(TablerIcons.credit_card),
                    title: const Text('Đặt hàng'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/checkout');
                    },
                  ),
              ]);
            },
          );
        },
      ),
    );
  }
}
