import 'package:big_apple/resources/values/app_duration.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';

class AppCameraComponent extends CameraComponent {
  AppCameraComponent({
    super.world,
    this.moveSpeed = 2,
    this.maxZoom = 2,
    this.minZoom = 1,
  });

  final double moveSpeed;
  final double maxZoom;
  final double minZoom;

  void onPanUpdate(DragUpdateInfo info) {
    final currentPosition = viewfinder.position;
    final scaledDelta = Vector2(info.delta.global.x, info.delta.global.y) * moveSpeed / viewfinder.zoom;
    final newPosition = currentPosition - scaledDelta;
    viewfinder.position = newPosition;
  }

  void onDoubleTapDown(TapDownInfo info) {
    final currentZoom = viewfinder.zoom.round();
    double newZoom;

    if (currentZoom >= maxZoom) {
      newZoom = minZoom;
    } else if (currentZoom <= minZoom) {
      newZoom = maxZoom;
    } else {
      newZoom = minZoom;
    }

    final moveEffect = MoveEffect.to(
      Vector2(info.eventPosition.widget.x, info.eventPosition.widget.y),
      EffectController(duration: AppDuration.defaultAnimationSpeed),
    );
    final zoomEffect = ScaleEffect.to(
      Vector2.all(newZoom),
      EffectController(duration: AppDuration.defaultAnimationSpeed),
    );

    viewfinder.add(moveEffect);
    viewfinder.add(zoomEffect);
  }
}
