import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import '../utils/assetsManager.dart';

class PlaceholderWidget extends StatelessWidget {
  const PlaceholderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(AppAnimation.emptyList),
          Text(
            "There is No Contacts Added Here",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Color(0xffFFF1D4),
            ),
          ),
        ],
      ),
    );
  }
}
