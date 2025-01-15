import 'package:flutter/material.dart';
import 'package:flutter_foods/core/log/app_logger.dart';
import 'package:flutter_foods/presentation/widgets/order_list.dart';
import 'package:flutter_foods/providers/order_provider.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:provider/provider.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() {
    return _MyOrderScreenState();
  }
}

class _MyOrderScreenState extends State<MyOrderScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final List<int> _statuses = [0, 1, 2, 3];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      _onTabChange();
    });
  }

  void _onTabChange() {
    if (!_tabController.indexIsChanging) return;
    _fetchOrders(_statuses[_tabController.index]);
  }

  void _fetchOrders(int status) {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    orderProvider.fetchByStatus(status);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đơn hàng của tôi'),
        bottom: TabBar(
          // Bỏ const ở đây
          controller: _tabController, // Thêm controller vào đây
          isScrollable: true,
          tabs: const [
            Tab(icon: Icon(TablerIcons.microwave), text: "Đang chuẩn bị"),
            Tab(
                icon: Icon(TablerIcons.truck_delivery),
                text: "Đang vận chuyển"),
            Tab(icon: Icon(TablerIcons.soup), text: "Đã giao"),
            Tab(icon: Icon(TablerIcons.x), text: "Đã hủy"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _statuses.map((status) => OrderList(status: status)).toList(),
      ),
    );
  }
}
