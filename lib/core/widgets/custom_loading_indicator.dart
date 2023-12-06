import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomLoadingIndicator extends StatefulWidget {
  const CustomLoadingIndicator({super.key});

  @override
  State<CustomLoadingIndicator> createState() => _CustomLoadingIndicatorState();
}

class _CustomLoadingIndicatorState extends State<CustomLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final ValueNotifier<int> _count = ValueNotifier<int>(1);
  final int _maxDots = 3;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _controller.addListener(() {
      _count.value = (_controller.value * _maxDots).floor() + 1;
    });
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    _count.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gap = 5.r;
    final height = 6.r;
    final width = _maxDots * height + (_maxDots - 1) * gap;

    return SizedBox(
      width: width,
      height: height,
      child: ValueListenableBuilder<int>(
        valueListenable: _count,
        builder: (context, value, child) => ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: value,
          itemBuilder: (context, index) => CircleAvatar(
            backgroundColor: Colors.white54,
            minRadius: height * 0.5,
            maxRadius: height * 0.5,
          ),
          separatorBuilder: (context, index) => SizedBox(width: gap),
        ),
      ),
    );
  }
}
