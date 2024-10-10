import 'package:flutter/material.dart';
import 'package:flutter_foods/presentation/widgets/appbar_normal.dart';
import 'package:flutter_foods/presentation/widgets/slider_drawer.dart';
import 'package:flutter_foods/providers/users_provider.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
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
    // final userProvider = Provider.of<UsersProvider>(context);

    return ZoomDrawer(
      style: DrawerStyle.style2,
      menuBackgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
      menuScreen: const SliderDrawer(),
      mainScreen: Scaffold(
        appBar: const AppbarNormal(),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.height * 1 / 2,
              floating: true,
              pinned: false,
              snap: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  'assets/images/food_delivery.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerLow,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  height: MediaQuery.of(context).size.height * 2 / 3,
                  child: const Center(
                    child: Text('Nội dung chính'),
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
