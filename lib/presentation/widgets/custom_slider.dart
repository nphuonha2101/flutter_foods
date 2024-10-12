import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_foods/data/models/i_model.dart';

class CustomSlider extends StatefulWidget {
  final List<IModel> items;
  final Widget Function(IModel) itemBuilder;
  final double height;

  const CustomSlider(
      {super.key,
      required this.items,
      required this.itemBuilder,
      required this.height});

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);

    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_currentPage < widget.items.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          return widget.itemBuilder(widget.items[index]);
        },
      ),
    );
  }
}
