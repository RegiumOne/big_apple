import 'package:big_apple/data/dto/enum/passive_benefit.dart';
import 'package:big_apple/data/dto/enum/passive_disadvantage.dart';
import 'package:big_apple/data/dto/enum/requirement_type.dart';
import 'package:big_apple/data/dto/enum/resource_type.dart';

abstract class Building<T extends Enum> {
  const Building({
    required this.currentLevel,
    required this.type,
  });

  final int currentLevel;
  final T type;

  double get buildingDurationInSeconds;
  Map<RequirementType, int> get requirements;
  Map<PassiveBenefit, int> get passiveBenefits;
  Map<PassiveDisadvantage, int> get passiveDisadvantages;
  Map<ResourceType, int> get price;
  String get title;
  String get description => 'Description maybe, why i must build it?';
  double get income;

  String imageInitial({bool replacePath = true});
  String imageHalf({bool replacePath = true});
  String imageDone({bool replacePath = true});

  Building<T> copyWith({
    int? currentLevel,
    T? type,
  });
}
