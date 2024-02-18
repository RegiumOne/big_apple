import 'package:big_apple/common/game/common_game.dart';
import 'package:big_apple/data/dto/enum/building_type.dart';
import 'package:big_apple/presentation/screens/shop/widgets/building_card.dart';
import 'package:big_apple/resources/values/app_dimension.dart';
import 'package:flutter/material.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({
    required this.game,
    super.key,
  });

  final CommonGame game;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimension.s16),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    "Buildings",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => game.hideShop(),
                    icon: const Icon(Icons.close, color: Colors.black),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: BuildingType.values.length,
                  itemBuilder: (context, index) => BuildingCard(
                    onPressed: () => game.placeBuilding(BuildingType.values[index]),
                    type: BuildingType.values[index],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
