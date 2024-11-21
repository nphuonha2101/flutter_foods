import 'package:flutter/material.dart';
import 'package:flutter_foods/presentation/screens/choose_address_screen.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class SliderDrawerWidget extends StatefulWidget {
  const SliderDrawerWidget({super.key});

  @override
  State<StatefulWidget> createState() => _SliderDrawerWidgetState();
}

class _SliderDrawerWidgetState extends State<SliderDrawerWidget> {
  bool isLogged = false;
  bool isAgency = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(),
            child: isLogged
                ? const Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            NetworkImage('https://via.placeholder.com/150'),
                      ),
                      SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('John Doe', style: TextStyle(fontSize: 20)),
                          Text('test@gmail.com',
                              style: TextStyle(fontSize: 14)),
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
            leading: const Icon(TablerIcons.login),
            title: const Text('Đăng nhập'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/login');
            },
          ),
          ListTile(
            leading: const Icon(TablerIcons.address_book),
            title: const Text('Địa chỉ'),
            onTap: () {
              Navigator.pop(context);
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
              Navigator.pop(context);
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
          )
        ],
      ),
    );
  }
}
