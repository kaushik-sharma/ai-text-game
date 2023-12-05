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

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _controller.addListener(() {
      _count.value = (_controller.value * 3).floor() + 1;
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
    return SizedBox(
      height: 6.h,
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
            minRadius: 3.r,
            maxRadius: 3.r,
          ),
          separatorBuilder: (context, index) => SizedBox(width: 5.w),
        ),
      ),
    );
  }
}
