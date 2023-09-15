import 'package:flutter/material.dart';

class Skeleton extends StatefulWidget {
  final double width, height;

  const Skeleton({super.key, required this.width, required this.height});

  @override
  State<Skeleton> createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation gradientPosition;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this);

    gradientPosition = Tween<double>(begin: -3, end: 10).animate(
      CurvedAnimation(parent: controller, curve: Curves.linear),
    )..addListener(() {
        setState(() {});
      });

    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(gradientPosition.value, 0),
          end: const Alignment(-1, 0),
          colors: const [Colors.black12, Colors.black26, Colors.black12],
        ),
      ),
    );
  }
}
