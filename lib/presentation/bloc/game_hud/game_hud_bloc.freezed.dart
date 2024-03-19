// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_hud_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GameHudEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GameStatistic gameStat) updateStatistic,
    required TResult Function(BuildingEntity building) selectBuilding,
    required TResult Function() hideBuilding,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(GameStatistic gameStat)? updateStatistic,
    TResult? Function(BuildingEntity building)? selectBuilding,
    TResult? Function()? hideBuilding,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GameStatistic gameStat)? updateStatistic,
    TResult Function(BuildingEntity building)? selectBuilding,
    TResult Function()? hideBuilding,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GameHudUpdateStatEvent value) updateStatistic,
    required TResult Function(_GameHudSelectBuildingEvent value) selectBuilding,
    required TResult Function(_GameHudHideBuildingEvent value) hideBuilding,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GameHudUpdateStatEvent value)? updateStatistic,
    TResult? Function(_GameHudSelectBuildingEvent value)? selectBuilding,
    TResult? Function(_GameHudHideBuildingEvent value)? hideBuilding,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GameHudUpdateStatEvent value)? updateStatistic,
    TResult Function(_GameHudSelectBuildingEvent value)? selectBuilding,
    TResult Function(_GameHudHideBuildingEvent value)? hideBuilding,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameHudEventCopyWith<$Res> {
  factory $GameHudEventCopyWith(
          GameHudEvent value, $Res Function(GameHudEvent) then) =
      _$GameHudEventCopyWithImpl<$Res, GameHudEvent>;
}

/// @nodoc
class _$GameHudEventCopyWithImpl<$Res, $Val extends GameHudEvent>
    implements $GameHudEventCopyWith<$Res> {
  _$GameHudEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$GameHudUpdateStatEventImplCopyWith<$Res> {
  factory _$$GameHudUpdateStatEventImplCopyWith(
          _$GameHudUpdateStatEventImpl value,
          $Res Function(_$GameHudUpdateStatEventImpl) then) =
      __$$GameHudUpdateStatEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({GameStatistic gameStat});
}

/// @nodoc
class __$$GameHudUpdateStatEventImplCopyWithImpl<$Res>
    extends _$GameHudEventCopyWithImpl<$Res, _$GameHudUpdateStatEventImpl>
    implements _$$GameHudUpdateStatEventImplCopyWith<$Res> {
  __$$GameHudUpdateStatEventImplCopyWithImpl(
      _$GameHudUpdateStatEventImpl _value,
      $Res Function(_$GameHudUpdateStatEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameStat = null,
  }) {
    return _then(_$GameHudUpdateStatEventImpl(
      null == gameStat
          ? _value.gameStat
          : gameStat // ignore: cast_nullable_to_non_nullable
              as GameStatistic,
    ));
  }
}

/// @nodoc

class _$GameHudUpdateStatEventImpl implements _GameHudUpdateStatEvent {
  const _$GameHudUpdateStatEventImpl(this.gameStat);

  @override
  final GameStatistic gameStat;

  @override
  String toString() {
    return 'GameHudEvent.updateStatistic(gameStat: $gameStat)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameHudUpdateStatEventImpl &&
            (identical(other.gameStat, gameStat) ||
                other.gameStat == gameStat));
  }

  @override
  int get hashCode => Object.hash(runtimeType, gameStat);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameHudUpdateStatEventImplCopyWith<_$GameHudUpdateStatEventImpl>
      get copyWith => __$$GameHudUpdateStatEventImplCopyWithImpl<
          _$GameHudUpdateStatEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GameStatistic gameStat) updateStatistic,
    required TResult Function(BuildingEntity building) selectBuilding,
    required TResult Function() hideBuilding,
  }) {
    return updateStatistic(gameStat);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(GameStatistic gameStat)? updateStatistic,
    TResult? Function(BuildingEntity building)? selectBuilding,
    TResult? Function()? hideBuilding,
  }) {
    return updateStatistic?.call(gameStat);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GameStatistic gameStat)? updateStatistic,
    TResult Function(BuildingEntity building)? selectBuilding,
    TResult Function()? hideBuilding,
    required TResult orElse(),
  }) {
    if (updateStatistic != null) {
      return updateStatistic(gameStat);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GameHudUpdateStatEvent value) updateStatistic,
    required TResult Function(_GameHudSelectBuildingEvent value) selectBuilding,
    required TResult Function(_GameHudHideBuildingEvent value) hideBuilding,
  }) {
    return updateStatistic(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GameHudUpdateStatEvent value)? updateStatistic,
    TResult? Function(_GameHudSelectBuildingEvent value)? selectBuilding,
    TResult? Function(_GameHudHideBuildingEvent value)? hideBuilding,
  }) {
    return updateStatistic?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GameHudUpdateStatEvent value)? updateStatistic,
    TResult Function(_GameHudSelectBuildingEvent value)? selectBuilding,
    TResult Function(_GameHudHideBuildingEvent value)? hideBuilding,
    required TResult orElse(),
  }) {
    if (updateStatistic != null) {
      return updateStatistic(this);
    }
    return orElse();
  }
}

abstract class _GameHudUpdateStatEvent implements GameHudEvent {
  const factory _GameHudUpdateStatEvent(final GameStatistic gameStat) =
      _$GameHudUpdateStatEventImpl;

  GameStatistic get gameStat;
  @JsonKey(ignore: true)
  _$$GameHudUpdateStatEventImplCopyWith<_$GameHudUpdateStatEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GameHudSelectBuildingEventImplCopyWith<$Res> {
  factory _$$GameHudSelectBuildingEventImplCopyWith(
          _$GameHudSelectBuildingEventImpl value,
          $Res Function(_$GameHudSelectBuildingEventImpl) then) =
      __$$GameHudSelectBuildingEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({BuildingEntity building});
}

/// @nodoc
class __$$GameHudSelectBuildingEventImplCopyWithImpl<$Res>
    extends _$GameHudEventCopyWithImpl<$Res, _$GameHudSelectBuildingEventImpl>
    implements _$$GameHudSelectBuildingEventImplCopyWith<$Res> {
  __$$GameHudSelectBuildingEventImplCopyWithImpl(
      _$GameHudSelectBuildingEventImpl _value,
      $Res Function(_$GameHudSelectBuildingEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? building = null,
  }) {
    return _then(_$GameHudSelectBuildingEventImpl(
      null == building
          ? _value.building
          : building // ignore: cast_nullable_to_non_nullable
              as BuildingEntity,
    ));
  }
}

/// @nodoc

class _$GameHudSelectBuildingEventImpl implements _GameHudSelectBuildingEvent {
  const _$GameHudSelectBuildingEventImpl(this.building);

  @override
  final BuildingEntity building;

  @override
  String toString() {
    return 'GameHudEvent.selectBuilding(building: $building)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameHudSelectBuildingEventImpl &&
            (identical(other.building, building) ||
                other.building == building));
  }

  @override
  int get hashCode => Object.hash(runtimeType, building);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameHudSelectBuildingEventImplCopyWith<_$GameHudSelectBuildingEventImpl>
      get copyWith => __$$GameHudSelectBuildingEventImplCopyWithImpl<
          _$GameHudSelectBuildingEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GameStatistic gameStat) updateStatistic,
    required TResult Function(BuildingEntity building) selectBuilding,
    required TResult Function() hideBuilding,
  }) {
    return selectBuilding(building);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(GameStatistic gameStat)? updateStatistic,
    TResult? Function(BuildingEntity building)? selectBuilding,
    TResult? Function()? hideBuilding,
  }) {
    return selectBuilding?.call(building);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GameStatistic gameStat)? updateStatistic,
    TResult Function(BuildingEntity building)? selectBuilding,
    TResult Function()? hideBuilding,
    required TResult orElse(),
  }) {
    if (selectBuilding != null) {
      return selectBuilding(building);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GameHudUpdateStatEvent value) updateStatistic,
    required TResult Function(_GameHudSelectBuildingEvent value) selectBuilding,
    required TResult Function(_GameHudHideBuildingEvent value) hideBuilding,
  }) {
    return selectBuilding(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GameHudUpdateStatEvent value)? updateStatistic,
    TResult? Function(_GameHudSelectBuildingEvent value)? selectBuilding,
    TResult? Function(_GameHudHideBuildingEvent value)? hideBuilding,
  }) {
    return selectBuilding?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GameHudUpdateStatEvent value)? updateStatistic,
    TResult Function(_GameHudSelectBuildingEvent value)? selectBuilding,
    TResult Function(_GameHudHideBuildingEvent value)? hideBuilding,
    required TResult orElse(),
  }) {
    if (selectBuilding != null) {
      return selectBuilding(this);
    }
    return orElse();
  }
}

abstract class _GameHudSelectBuildingEvent implements GameHudEvent {
  const factory _GameHudSelectBuildingEvent(final BuildingEntity building) =
      _$GameHudSelectBuildingEventImpl;

  BuildingEntity get building;
  @JsonKey(ignore: true)
  _$$GameHudSelectBuildingEventImplCopyWith<_$GameHudSelectBuildingEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GameHudHideBuildingEventImplCopyWith<$Res> {
  factory _$$GameHudHideBuildingEventImplCopyWith(
          _$GameHudHideBuildingEventImpl value,
          $Res Function(_$GameHudHideBuildingEventImpl) then) =
      __$$GameHudHideBuildingEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GameHudHideBuildingEventImplCopyWithImpl<$Res>
    extends _$GameHudEventCopyWithImpl<$Res, _$GameHudHideBuildingEventImpl>
    implements _$$GameHudHideBuildingEventImplCopyWith<$Res> {
  __$$GameHudHideBuildingEventImplCopyWithImpl(
      _$GameHudHideBuildingEventImpl _value,
      $Res Function(_$GameHudHideBuildingEventImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$GameHudHideBuildingEventImpl implements _GameHudHideBuildingEvent {
  const _$GameHudHideBuildingEventImpl();

  @override
  String toString() {
    return 'GameHudEvent.hideBuilding()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameHudHideBuildingEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GameStatistic gameStat) updateStatistic,
    required TResult Function(BuildingEntity building) selectBuilding,
    required TResult Function() hideBuilding,
  }) {
    return hideBuilding();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(GameStatistic gameStat)? updateStatistic,
    TResult? Function(BuildingEntity building)? selectBuilding,
    TResult? Function()? hideBuilding,
  }) {
    return hideBuilding?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GameStatistic gameStat)? updateStatistic,
    TResult Function(BuildingEntity building)? selectBuilding,
    TResult Function()? hideBuilding,
    required TResult orElse(),
  }) {
    if (hideBuilding != null) {
      return hideBuilding();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GameHudUpdateStatEvent value) updateStatistic,
    required TResult Function(_GameHudSelectBuildingEvent value) selectBuilding,
    required TResult Function(_GameHudHideBuildingEvent value) hideBuilding,
  }) {
    return hideBuilding(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GameHudUpdateStatEvent value)? updateStatistic,
    TResult? Function(_GameHudSelectBuildingEvent value)? selectBuilding,
    TResult? Function(_GameHudHideBuildingEvent value)? hideBuilding,
  }) {
    return hideBuilding?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GameHudUpdateStatEvent value)? updateStatistic,
    TResult Function(_GameHudSelectBuildingEvent value)? selectBuilding,
    TResult Function(_GameHudHideBuildingEvent value)? hideBuilding,
    required TResult orElse(),
  }) {
    if (hideBuilding != null) {
      return hideBuilding(this);
    }
    return orElse();
  }
}

abstract class _GameHudHideBuildingEvent implements GameHudEvent {
  const factory _GameHudHideBuildingEvent() = _$GameHudHideBuildingEventImpl;
}

/// @nodoc
mixin _$GameHudState {
  GameStatistic get gameStat => throw _privateConstructorUsedError;
  BuildingEntity? get selectedBuilding => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GameHudStateCopyWith<GameHudState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameHudStateCopyWith<$Res> {
  factory $GameHudStateCopyWith(
          GameHudState value, $Res Function(GameHudState) then) =
      _$GameHudStateCopyWithImpl<$Res, GameHudState>;
  @useResult
  $Res call({GameStatistic gameStat, BuildingEntity? selectedBuilding});
}

/// @nodoc
class _$GameHudStateCopyWithImpl<$Res, $Val extends GameHudState>
    implements $GameHudStateCopyWith<$Res> {
  _$GameHudStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameStat = null,
    Object? selectedBuilding = freezed,
  }) {
    return _then(_value.copyWith(
      gameStat: null == gameStat
          ? _value.gameStat
          : gameStat // ignore: cast_nullable_to_non_nullable
              as GameStatistic,
      selectedBuilding: freezed == selectedBuilding
          ? _value.selectedBuilding
          : selectedBuilding // ignore: cast_nullable_to_non_nullable
              as BuildingEntity?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameHudStateImplCopyWith<$Res>
    implements $GameHudStateCopyWith<$Res> {
  factory _$$GameHudStateImplCopyWith(
          _$GameHudStateImpl value, $Res Function(_$GameHudStateImpl) then) =
      __$$GameHudStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({GameStatistic gameStat, BuildingEntity? selectedBuilding});
}

/// @nodoc
class __$$GameHudStateImplCopyWithImpl<$Res>
    extends _$GameHudStateCopyWithImpl<$Res, _$GameHudStateImpl>
    implements _$$GameHudStateImplCopyWith<$Res> {
  __$$GameHudStateImplCopyWithImpl(
      _$GameHudStateImpl _value, $Res Function(_$GameHudStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameStat = null,
    Object? selectedBuilding = freezed,
  }) {
    return _then(_$GameHudStateImpl(
      gameStat: null == gameStat
          ? _value.gameStat
          : gameStat // ignore: cast_nullable_to_non_nullable
              as GameStatistic,
      selectedBuilding: freezed == selectedBuilding
          ? _value.selectedBuilding
          : selectedBuilding // ignore: cast_nullable_to_non_nullable
              as BuildingEntity?,
    ));
  }
}

/// @nodoc

class _$GameHudStateImpl implements _GameHudState {
  const _$GameHudStateImpl(
      {required this.gameStat, required this.selectedBuilding});

  @override
  final GameStatistic gameStat;
  @override
  final BuildingEntity? selectedBuilding;

  @override
  String toString() {
    return 'GameHudState(gameStat: $gameStat, selectedBuilding: $selectedBuilding)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameHudStateImpl &&
            (identical(other.gameStat, gameStat) ||
                other.gameStat == gameStat) &&
            (identical(other.selectedBuilding, selectedBuilding) ||
                other.selectedBuilding == selectedBuilding));
  }

  @override
  int get hashCode => Object.hash(runtimeType, gameStat, selectedBuilding);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameHudStateImplCopyWith<_$GameHudStateImpl> get copyWith =>
      __$$GameHudStateImplCopyWithImpl<_$GameHudStateImpl>(this, _$identity);
}

abstract class _GameHudState implements GameHudState {
  const factory _GameHudState(
      {required final GameStatistic gameStat,
      required final BuildingEntity? selectedBuilding}) = _$GameHudStateImpl;

  @override
  GameStatistic get gameStat;
  @override
  BuildingEntity? get selectedBuilding;
  @override
  @JsonKey(ignore: true)
  _$$GameHudStateImplCopyWith<_$GameHudStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
