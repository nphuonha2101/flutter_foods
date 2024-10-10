import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SliderDrawer extends StatefulWidget {
  const SliderDrawer({super.key});

  @override
  State<StatefulWidget> createState() => _SliderDrawerState();
}

class _SliderDrawerState extends State<SliderDrawer> {
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
            leading: const Icon(Icons.login_rounded),
            title: const Text('Đăng nhập'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
