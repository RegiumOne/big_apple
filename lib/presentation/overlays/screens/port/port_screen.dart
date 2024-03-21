import 'package:big_apple/common/game/common_game.dart';
import 'package:big_apple/common/services/audio_service.dart';
import 'package:big_apple/data/dto/enum/port_menu.dart';
import 'package:big_apple/presentation/overlays/app_overlay.dart';
import 'package:big_apple/presentation/overlays/screens/port/widgets/port_import_container_widget.dart';
import 'package:big_apple/presentation/overlays/screens/port/widgets/port_storage_content_widget.dart';
import 'package:big_apple/presentation/widgets/background_bottom_widget.dart';
import 'package:flutter/material.dart';

class PortScreen extends StatefulWidget {
  const PortScreen({
    required this.game,
    required this.overlay,
    required this.selectedMenu,
    super.key,
  });

  final CommonGame game;
  final String overlay;
  final PortMenu selectedMenu;

  @override
  State<PortScreen> createState() => _PortScreenState();
}

class _PortScreenState extends State<PortScreen> {
  PortMenu _selectedMenu = PortMenu.portStorage;

  @override
  void initState() {
    _selectedMenu = widget.selectedMenu;
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
    Widget child = const SizedBox.shrink();
    switch (_selectedMenu) {
      case PortMenu.portStorage:
        child = const PortStorageContentWidget();
        break;
      case PortMenu.portImport:
        child = const PortImportContainerWidget();
        break;
    }

    return BackgroundBottomWidget<PortMenu>(
      items: PortMenu.values.map((e) => CategoryMenu(title: e.title, gradient: e.gradient, category: e)).toList(),
      onCategoryChange: (category) {
        setState(() {
          _selectedMenu = category.category;
        });
      },
      selectedCategory: CategoryMenu(
        title: _selectedMenu.title,
        gradient: _selectedMenu.gradient,
        category: _selectedMenu,
      ),
      onClose: () {
        _hideShop();
      },
      child: child,
    );
  }

  void _hideShop() {
    widget.game.overlays.add(Overlays.hud.name);
    widget.game.overlays.remove(widget.overlay);
  }
}
