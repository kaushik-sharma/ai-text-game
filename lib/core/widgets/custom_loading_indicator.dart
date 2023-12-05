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
  final ValueNotifier<double> _controllerValue = ValueNotifier<double>(0.0);
  final int _maxDots = 3;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _controller.addListener(() {
      _controllerValue.value = _controller.value;
    });
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controllerValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 6.h,
      child: ValueListenableBuilder<double>(
        valueListenable: _controllerValue,
        builder: (context, value, child) => ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: (value * _maxDots).floor() + 1,
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
