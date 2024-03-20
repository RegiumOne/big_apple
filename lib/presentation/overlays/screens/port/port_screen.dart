import 'package:big_apple/common/game/common_game.dart';
import 'package:big_apple/common/services/audio_service.dart';
import 'package:big_apple/data/dto/enum/port_menu.dart';
import 'package:big_apple/data/dto/enum/resource_type.dart';
import 'package:big_apple/generated/assets.gen.dart';
import 'package:big_apple/presentation/overlays/app_overlay.dart';
import 'package:big_apple/presentation/widgets/background_bottom_widget.dart';
import 'package:big_apple/presentation/widgets/resource_with_text_widget.dart';
import 'package:big_apple/presentation/widgets/text_widget.dart';
import 'package:big_apple/resources/values/app_colors.dart';
import 'package:big_apple/resources/values/app_dimension.dart';
import 'package:flutter/material.dart';

class PortScreen extends StatefulWidget {
  const PortScreen({
    required this.game,
    super.key,
  });

  final CommonGame game;

  @override
  State<PortScreen> createState() => _PortScreenState();
}

class _PortScreenState extends State<PortScreen> {
  PortMenu _selectedCategory = PortMenu.portStorage;

  @override
  void initState() {
    AudioService.instance.playPopupWindowMusic();
    super.initState();
  }

  @override
  void dispose() {
    widget.game.checkMusic();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BackgroundBottomWidget<PortMenu>(
      items: PortMenu.values.map((e) => CategoryMenu(title: e.title, gradient: e.gradient, category: e)).toList(),
      onCategoryChange: (category) {
        setState(() {
          _selectedCategory = category.category;
        });
      },
      selectedCategory: CategoryMenu(
        title: _selectedCategory.title,
        gradient: _selectedCategory.gradient,
        category: _selectedCategory,
      ),
      onClose: () {
        _hideShop();
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 259,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(AppDimension.r10)),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 258),
                child: Assets.images.portStorage.image(
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppDimension.s12),
          Expanded(
            flex: 404,
            child: Wrap(
              spacing: AppDimension.s6,
              runSpacing: AppDimension.s8,
              children: ResourceType.mainResources.map((e) {
                return Container(
                  width: AppDimension.s110,
                  height: AppDimension.s96,
                  decoration: const BoxDecoration(
                    color: AppColors.colorPaleTaupe,
                    borderRadius: BorderRadius.all(Radius.circular(AppDimension.r10)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ResourceWithTextWidget(
                        resourceTypeIcon: e.icon(),
                        value: 100,
                      ),
                      const SizedBox(height: AppDimension.s8),
                      TextWidget(
                        e.title,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.black,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  void _hideShop() {
    widget.game.overlays.add(Overlays.hud.name);
    widget.game.overlays.remove(Overlays.port.name);
  }
}
