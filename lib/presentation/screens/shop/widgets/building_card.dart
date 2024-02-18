import 'package:big_apple/data/dto/enum/building_type.dart';
import 'package:big_apple/resources/values/app_dimension.dart';
import 'package:flutter/material.dart';

class BuildingCard extends StatelessWidget {
  const BuildingCard({
    required this.type,
    this.onPressed,
    super.key,
  });

  final BuildingType type;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.all(AppDimension.s16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                type.imageDone(replacePath: false),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppDimension.s8),
            child: Column(
              children: [
                Text(
                  type.title(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppDimension.s8),
                Text(
                  "\$ ${type.cost.toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: AppDimension.s8),
                TextButton(
                  onPressed: onPressed,
                  child: const Text("Buy"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
