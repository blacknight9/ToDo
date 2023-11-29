import 'package:ent5m/constants/Colors.dart';
import 'package:flutter/material.dart';

class ResponsiveMaxWidthContainer extends StatelessWidget {
  final Widget child;
  final double maxWidthPercentage;

  const ResponsiveMaxWidthContainer({Key? key, required this.child, this.maxWidthPercentage = 0.7}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the screen width
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate the maximum width based on the percentage
    final maxWidth = screenWidth * maxWidthPercentage;

    return Center(
      child: Container(
        decoration: const BoxDecoration(
          color: myPrimary,
        ),
        constraints: BoxConstraints(
          maxWidth: screenWidth > 1000 ? maxWidth : screenWidth, // Use the calculated maximum width
        ),
        child: child,
      ),
    );
  }
}
