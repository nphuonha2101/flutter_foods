import 'package:flutter/material.dart';
import 'package:flutter_foods/presentation/screens/choose_address_screen.dart';
import 'package:flutter_foods/providers/auth_provider.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SliderDrawerWidget extends StatelessWidget {
  const SliderDrawerWidget({super.key});

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

              return ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: const BoxDecoration(),
                    child: isLogged
                        ? Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                  authCredential?.avatar ?? 'https://via.placeholder.com/150',
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
                                  ),
                                  Text(
                                    authCredential?.userEmail ?? 'test@gmail.com',
                                    style: const TextStyle(fontSize: 14),
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
                  ListTile(
                    leading: const Icon(TablerIcons.shopping_cart),
                    title: const Text('Giỏ hàng'),
                    onTap: () {
                      Navigator.pushNamed(context, '/cart');
                    },
                  ),
                  ListTile(
                    leading: const Icon(TablerIcons.credit_card),
                    title: const Text('Đặt hàng'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/checkout');
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
