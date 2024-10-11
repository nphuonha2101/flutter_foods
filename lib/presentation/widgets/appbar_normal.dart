import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class AppbarNormal extends StatefulWidget implements PreferredSizeWidget {
  const AppbarNormal({super.key});

  @override
  State<StatefulWidget> createState() => _AppbarNormalState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppbarNormalState extends State<AppbarNormal> {
  String title = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(title),
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 5, bottom: 5),
            child: Material(
              color: Theme.of(context).colorScheme.surfaceContainerLow,
              borderRadius: const BorderRadius.all(Radius.circular(100)),
              child: IconButton(
                icon: const Icon(TablerIcons.menu),
                onPressed: () {
                  ZoomDrawer.of(context)!.toggle();
                },
              ),
            ),
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 20.0, top: 5, bottom: 5),
                child: Material(
                  color: Theme.of(context).colorScheme.surfaceContainerLow,
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  child: IconButton(
                    icon: const Icon(TablerIcons.search),
                    onPressed: () {},
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(right: 10.0, top: 5, bottom: 5),
              child: Material(
                color: Theme.of(context).colorScheme.surfaceContainerLow,
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(
                    "assets/images/food_delivery.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
