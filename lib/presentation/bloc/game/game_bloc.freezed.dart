// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GameEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GameStat gameStat) updateStat,
    required TResult Function(BuildingEntity building) selectBuilding,
    required TResult Function() hideBuilding,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(GameStat gameStat)? updateStat,
    TResult? Function(BuildingEntity building)? selectBuilding,
    TResult? Function()? hideBuilding,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GameStat gameStat)? updateStat,
    TResult Function(BuildingEntity building)? selectBuilding,
    TResult Function()? hideBuilding,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GameUpdateStatEvent value) updateStat,
    required TResult Function(_GameSelectBuildingEvent value) selectBuilding,
    required TResult Function(_GameHideBuildingEvent value) hideBuilding,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GameUpdateStatEvent value)? updateStat,
    TResult? Function(_GameSelectBuildingEvent value)? selectBuilding,
    TResult? Function(_GameHideBuildingEvent value)? hideBuilding,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GameUpdateStatEvent value)? updateStat,
    TResult Function(_GameSelectBuildingEvent value)? selectBuilding,
    TResult Function(_GameHideBuildingEvent value)? hideBuilding,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameEventCopyWith<$Res> {
  factory $GameEventCopyWith(GameEvent value, $Res Function(GameEvent) then) =
      _$GameEventCopyWithImpl<$Res, GameEvent>;
}

/// @nodoc
class _$GameEventCopyWithImpl<$Res, $Val extends GameEvent>
    implements $GameEventCopyWith<$Res> {
  _$GameEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$GameUpdateStatEventImplCopyWith<$Res> {
  factory _$$GameUpdateStatEventImplCopyWith(_$GameUpdateStatEventImpl value,
          $Res Function(_$GameUpdateStatEventImpl) then) =
      __$$GameUpdateStatEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({GameStat gameStat});
}

/// @nodoc
class __$$GameUpdateStatEventImplCopyWithImpl<$Res>
    extends _$GameEventCopyWithImpl<$Res, _$GameUpdateStatEventImpl>
    implements _$$GameUpdateStatEventImplCopyWith<$Res> {
  __$$GameUpdateStatEventImplCopyWithImpl(_$GameUpdateStatEventImpl _value,
      $Res Function(_$GameUpdateStatEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameStat = null,
  }) {
    return _then(_$GameUpdateStatEventImpl(
      null == gameStat
          ? _value.gameStat
          : gameStat // ignore: cast_nullable_to_non_nullable
              as GameStat,
    ));
  }
}

/// @nodoc

class _$GameUpdateStatEventImpl implements _GameUpdateStatEvent {
  const _$GameUpdateStatEventImpl(this.gameStat);

  @override
  final GameStat gameStat;

  @override
  String toString() {
    return 'GameEvent.updateStat(gameStat: $gameStat)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameUpdateStatEventImpl &&
            (identical(other.gameStat, gameStat) ||
                other.gameStat == gameStat));
  }

  @override
  int get hashCode => Object.hash(runtimeType, gameStat);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameUpdateStatEventImplCopyWith<_$GameUpdateStatEventImpl> get copyWith =>
      __$$GameUpdateStatEventImplCopyWithImpl<_$GameUpdateStatEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GameStat gameStat) updateStat,
    required TResult Function(BuildingEntity building) selectBuilding,
    required TResult Function() hideBuilding,
  }) {
    return updateStat(gameStat);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(GameStat gameStat)? updateStat,
    TResult? Function(BuildingEntity building)? selectBuilding,
    TResult? Function()? hideBuilding,
  }) {
    return updateStat?.call(gameStat);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GameStat gameStat)? updateStat,
    TResult Function(BuildingEntity building)? selectBuilding,
    TResult Function()? hideBuilding,
    required TResult orElse(),
  }) {
    if (updateStat != null) {
      return updateStat(gameStat);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GameUpdateStatEvent value) updateStat,
    required TResult Function(_GameSelectBuildingEvent value) selectBuilding,
    required TResult Function(_GameHideBuildingEvent value) hideBuilding,
  }) {
    return updateStat(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GameUpdateStatEvent value)? updateStat,
    TResult? Function(_GameSelectBuildingEvent value)? selectBuilding,
    TResult? Function(_GameHideBuildingEvent value)? hideBuilding,
  }) {
    return updateStat?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GameUpdateStatEvent value)? updateStat,
    TResult Function(_GameSelectBuildingEvent value)? selectBuilding,
    TResult Function(_GameHideBuildingEvent value)? hideBuilding,
    required TResult orElse(),
  }) {
    if (updateStat != null) {
      return updateStat(this);
    }
    return orElse();
  }
}

abstract class _GameUpdateStatEvent implements GameEvent {
  const factory _GameUpdateStatEvent(final GameStat gameStat) =
      _$GameUpdateStatEventImpl;

  GameStat get gameStat;
  @JsonKey(ignore: true)
  _$$GameUpdateStatEventImplCopyWith<_$GameUpdateStatEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GameSelectBuildingEventImplCopyWith<$Res> {
  factory _$$GameSelectBuildingEventImplCopyWith(
          _$GameSelectBuildingEventImpl value,
          $Res Function(_$GameSelectBuildingEventImpl) then) =
      __$$GameSelectBuildingEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({BuildingEntity building});
}

/// @nodoc
class __$$GameSelectBuildingEventImplCopyWithImpl<$Res>
    extends _$GameEventCopyWithImpl<$Res, _$GameSelectBuildingEventImpl>
    implements _$$GameSelectBuildingEventImplCopyWith<$Res> {
  __$$GameSelectBuildingEventImplCopyWithImpl(
      _$GameSelectBuildingEventImpl _value,
      $Res Function(_$GameSelectBuildingEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? building = null,
  }) {
    return _then(_$GameSelectBuildingEventImpl(
      null == building
          ? _value.building
          : building // ignore: cast_nullable_to_non_nullable
              as BuildingEntity,
    ));
  }
}

/// @nodoc

class _$GameSelectBuildingEventImpl implements _GameSelectBuildingEvent {
  const _$GameSelectBuildingEventImpl(this.building);

  @override
  final BuildingEntity building;

  @override
  String toString() {
    return 'GameEvent.selectBuilding(building: $building)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameSelectBuildingEventImpl &&
            (identical(other.building, building) ||
                other.building == building));
  }

  @override
  int get hashCode => Object.hash(runtimeType, building);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameSelectBuildingEventImplCopyWith<_$GameSelectBuildingEventImpl>
      get copyWith => __$$GameSelectBuildingEventImplCopyWithImpl<
          _$GameSelectBuildingEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GameStat gameStat) updateStat,
    required TResult Function(BuildingEntity building) selectBuilding,
    required TResult Function() hideBuilding,
  }) {
    return selectBuilding(building);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(GameStat gameStat)? updateStat,
    TResult? Function(BuildingEntity building)? selectBuilding,
    TResult? Function()? hideBuilding,
  }) {
    return selectBuilding?.call(building);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GameStat gameStat)? updateStat,
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
    required TResult Function(_GameUpdateStatEvent value) updateStat,
    required TResult Function(_GameSelectBuildingEvent value) selectBuilding,
    required TResult Function(_GameHideBuildingEvent value) hideBuilding,
  }) {
    return selectBuilding(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GameUpdateStatEvent value)? updateStat,
    TResult? Function(_GameSelectBuildingEvent value)? selectBuilding,
    TResult? Function(_GameHideBuildingEvent value)? hideBuilding,
  }) {
    return selectBuilding?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GameUpdateStatEvent value)? updateStat,
    TResult Function(_GameSelectBuildingEvent value)? selectBuilding,
    TResult Function(_GameHideBuildingEvent value)? hideBuilding,
    required TResult orElse(),
  }) {
    if (selectBuilding != null) {
      return selectBuilding(this);
    }
    return orElse();
  }
}

abstract class _GameSelectBuildingEvent implements GameEvent {
  const factory _GameSelectBuildingEvent(final BuildingEntity building) =
      _$GameSelectBuildingEventImpl;

  BuildingEntity get building;
  @JsonKey(ignore: true)
  _$$GameSelectBuildingEventImplCopyWith<_$GameSelectBuildingEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GameHideBuildingEventImplCopyWith<$Res> {
  factory _$$GameHideBuildingEventImplCopyWith(
          _$GameHideBuildingEventImpl value,
          $Res Function(_$GameHideBuildingEventImpl) then) =
      __$$GameHideBuildingEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GameHideBuildingEventImplCopyWithImpl<$Res>
    extends _$GameEventCopyWithImpl<$Res, _$GameHideBuildingEventImpl>
    implements _$$GameHideBuildingEventImplCopyWith<$Res> {
  __$$GameHideBuildingEventImplCopyWithImpl(_$GameHideBuildingEventImpl _value,
      $Res Function(_$GameHideBuildingEventImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$GameHideBuildingEventImpl implements _GameHideBuildingEvent {
  const _$GameHideBuildingEventImpl();

  @override
  String toString() {
    return 'GameEvent.hideBuilding()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameHideBuildingEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GameStat gameStat) updateStat,
    required TResult Function(BuildingEntity building) selectBuilding,
    required TResult Function() hideBuilding,
  }) {
    return hideBuilding();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(GameStat gameStat)? updateStat,
    TResult? Function(BuildingEntity building)? selectBuilding,
    TResult? Function()? hideBuilding,
  }) {
    return hideBuilding?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GameStat gameStat)? updateStat,
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
    required TResult Function(_GameUpdateStatEvent value) updateStat,
    required TResult Function(_GameSelectBuildingEvent value) selectBuilding,
    required TResult Function(_GameHideBuildingEvent value) hideBuilding,
  }) {
    return hideBuilding(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GameUpdateStatEvent value)? updateStat,
    TResult? Function(_GameSelectBuildingEvent value)? selectBuilding,
    TResult? Function(_GameHideBuildingEvent value)? hideBuilding,
  }) {
    return hideBuilding?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GameUpdateStatEvent value)? updateStat,
    TResult Function(_GameSelectBuildingEvent value)? selectBuilding,
    TResult Function(_GameHideBuildingEvent value)? hideBuilding,
    required TResult orElse(),
  }) {
    if (hideBuilding != null) {
      return hideBuilding(this);
    }
    return orElse();
  }
}

abstract class _GameHideBuildingEvent implements GameEvent {
  const factory _GameHideBuildingEvent() = _$GameHideBuildingEventImpl;
}

/// @nodoc
mixin _$GameState {
  GameStat get gameStat => throw _privateConstructorUsedError;
  BuildingEntity? get selectedBuilding => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GameStateCopyWith<GameState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameStateCopyWith<$Res> {
  factory $GameStateCopyWith(GameState value, $Res Function(GameState) then) =
      _$GameStateCopyWithImpl<$Res, GameState>;
  @useResult
  $Res call({GameStat gameStat, BuildingEntity? selectedBuilding});
}

/// @nodoc
class _$GameStateCopyWithImpl<$Res, $Val extends GameState>
    implements $GameStateCopyWith<$Res> {
  _$GameStateCopyWithImpl(this._value, this._then);

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
              as GameStat,
      selectedBuilding: freezed == selectedBuilding
          ? _value.selectedBuilding
          : selectedBuilding // ignore: cast_nullable_to_non_nullable
              as BuildingEntity?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameStateImplCopyWith<$Res>
    implements $GameStateCopyWith<$Res> {
  factory _$$GameStateImplCopyWith(
          _$GameStateImpl value, $Res Function(_$GameStateImpl) then) =
      __$$GameStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({GameStat gameStat, BuildingEntity? selectedBuilding});
}

/// @nodoc
class __$$GameStateImplCopyWithImpl<$Res>
    extends _$GameStateCopyWithImpl<$Res, _$GameStateImpl>
    implements _$$GameStateImplCopyWith<$Res> {
  __$$GameStateImplCopyWithImpl(
      _$GameStateImpl _value, $Res Function(_$GameStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameStat = null,
    Object? selectedBuilding = freezed,
  }) {
    return _then(_$GameStateImpl(
      gameStat: null == gameStat
          ? _value.gameStat
          : gameStat // ignore: cast_nullable_to_non_nullable
              as GameStat,
      selectedBuilding: freezed == selectedBuilding
          ? _value.selectedBuilding
          : selectedBuilding // ignore: cast_nullable_to_non_nullable
              as BuildingEntity?,
    ));
  }
}

/// @nodoc

class _$GameStateImpl implements _GameState {
  const _$GameStateImpl(
      {required this.gameStat, required this.selectedBuilding});

  @override
  final GameStat gameStat;
  @override
  final BuildingEntity? selectedBuilding;

  @override
  String toString() {
    return 'GameState(gameStat: $gameStat, selectedBuilding: $selectedBuilding)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameStateImpl &&
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
  _$$GameStateImplCopyWith<_$GameStateImpl> get copyWith =>
      __$$GameStateImplCopyWithImpl<_$GameStateImpl>(this, _$identity);
}

abstract class _GameState implements GameState {
  const factory _GameState(
      {required final GameStat gameStat,
      required final BuildingEntity? selectedBuilding}) = _$GameStateImpl;

  @override
  GameStat get gameStat;
  @override
  BuildingEntity? get selectedBuilding;
  @override
  @JsonKey(ignore: true)
  _$$GameStateImplCopyWith<_$GameStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
