// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GameState {
  GameStatistic get gameStatistic => throw _privateConstructorUsedError;
  List<BuildingEntity> get buildinds => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            GameStatistic gameStatistic, List<BuildingEntity> buildinds)
        initBuildings,
    required TResult Function(
            GameStatistic gameStatistic, List<BuildingEntity> buildinds)
        updateStat,
    required TResult Function(GameStatistic gameStatistic,
            List<BuildingEntity> buildinds, int newLevel)
        onNewLevel,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            GameStatistic gameStatistic, List<BuildingEntity> buildinds)?
        initBuildings,
    TResult? Function(
            GameStatistic gameStatistic, List<BuildingEntity> buildinds)?
        updateStat,
    TResult? Function(GameStatistic gameStatistic,
            List<BuildingEntity> buildinds, int newLevel)?
        onNewLevel,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            GameStatistic gameStatistic, List<BuildingEntity> buildinds)?
        initBuildings,
    TResult Function(
            GameStatistic gameStatistic, List<BuildingEntity> buildinds)?
        updateStat,
    TResult Function(GameStatistic gameStatistic,
            List<BuildingEntity> buildinds, int newLevel)?
        onNewLevel,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GameInitBuildingsState value) initBuildings,
    required TResult Function(_GameUpdateStatState value) updateStat,
    required TResult Function(_GameOnNewLevelState value) onNewLevel,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GameInitBuildingsState value)? initBuildings,
    TResult? Function(_GameUpdateStatState value)? updateStat,
    TResult? Function(_GameOnNewLevelState value)? onNewLevel,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GameInitBuildingsState value)? initBuildings,
    TResult Function(_GameUpdateStatState value)? updateStat,
    TResult Function(_GameOnNewLevelState value)? onNewLevel,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GameStateCopyWith<GameState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameStateCopyWith<$Res> {
  factory $GameStateCopyWith(GameState value, $Res Function(GameState) then) =
      _$GameStateCopyWithImpl<$Res, GameState>;
  @useResult
  $Res call({GameStatistic gameStatistic, List<BuildingEntity> buildinds});
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
    Object? gameStatistic = null,
    Object? buildinds = null,
  }) {
    return _then(_value.copyWith(
      gameStatistic: null == gameStatistic
          ? _value.gameStatistic
          : gameStatistic // ignore: cast_nullable_to_non_nullable
              as GameStatistic,
      buildinds: null == buildinds
          ? _value.buildinds
          : buildinds // ignore: cast_nullable_to_non_nullable
              as List<BuildingEntity>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameInitBuildingsStateImplCopyWith<$Res>
    implements $GameStateCopyWith<$Res> {
  factory _$$GameInitBuildingsStateImplCopyWith(
          _$GameInitBuildingsStateImpl value,
          $Res Function(_$GameInitBuildingsStateImpl) then) =
      __$$GameInitBuildingsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({GameStatistic gameStatistic, List<BuildingEntity> buildinds});
}

/// @nodoc
class __$$GameInitBuildingsStateImplCopyWithImpl<$Res>
    extends _$GameStateCopyWithImpl<$Res, _$GameInitBuildingsStateImpl>
    implements _$$GameInitBuildingsStateImplCopyWith<$Res> {
  __$$GameInitBuildingsStateImplCopyWithImpl(
      _$GameInitBuildingsStateImpl _value,
      $Res Function(_$GameInitBuildingsStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameStatistic = null,
    Object? buildinds = null,
  }) {
    return _then(_$GameInitBuildingsStateImpl(
      null == gameStatistic
          ? _value.gameStatistic
          : gameStatistic // ignore: cast_nullable_to_non_nullable
              as GameStatistic,
      null == buildinds
          ? _value._buildinds
          : buildinds // ignore: cast_nullable_to_non_nullable
              as List<BuildingEntity>,
    ));
  }
}

/// @nodoc

class _$GameInitBuildingsStateImpl implements _GameInitBuildingsState {
  const _$GameInitBuildingsStateImpl(
      this.gameStatistic, final List<BuildingEntity> buildinds)
      : _buildinds = buildinds;

  @override
  final GameStatistic gameStatistic;
  final List<BuildingEntity> _buildinds;
  @override
  List<BuildingEntity> get buildinds {
    if (_buildinds is EqualUnmodifiableListView) return _buildinds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_buildinds);
  }

  @override
  String toString() {
    return 'GameState.initBuildings(gameStatistic: $gameStatistic, buildinds: $buildinds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameInitBuildingsStateImpl &&
            (identical(other.gameStatistic, gameStatistic) ||
                other.gameStatistic == gameStatistic) &&
            const DeepCollectionEquality()
                .equals(other._buildinds, _buildinds));
  }

  @override
  int get hashCode => Object.hash(runtimeType, gameStatistic,
      const DeepCollectionEquality().hash(_buildinds));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameInitBuildingsStateImplCopyWith<_$GameInitBuildingsStateImpl>
      get copyWith => __$$GameInitBuildingsStateImplCopyWithImpl<
          _$GameInitBuildingsStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            GameStatistic gameStatistic, List<BuildingEntity> buildinds)
        initBuildings,
    required TResult Function(
            GameStatistic gameStatistic, List<BuildingEntity> buildinds)
        updateStat,
    required TResult Function(GameStatistic gameStatistic,
            List<BuildingEntity> buildinds, int newLevel)
        onNewLevel,
  }) {
    return initBuildings(gameStatistic, buildinds);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            GameStatistic gameStatistic, List<BuildingEntity> buildinds)?
        initBuildings,
    TResult? Function(
            GameStatistic gameStatistic, List<BuildingEntity> buildinds)?
        updateStat,
    TResult? Function(GameStatistic gameStatistic,
            List<BuildingEntity> buildinds, int newLevel)?
        onNewLevel,
  }) {
    return initBuildings?.call(gameStatistic, buildinds);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            GameStatistic gameStatistic, List<BuildingEntity> buildinds)?
        initBuildings,
    TResult Function(
            GameStatistic gameStatistic, List<BuildingEntity> buildinds)?
        updateStat,
    TResult Function(GameStatistic gameStatistic,
            List<BuildingEntity> buildinds, int newLevel)?
        onNewLevel,
    required TResult orElse(),
  }) {
    if (initBuildings != null) {
      return initBuildings(gameStatistic, buildinds);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GameInitBuildingsState value) initBuildings,
    required TResult Function(_GameUpdateStatState value) updateStat,
    required TResult Function(_GameOnNewLevelState value) onNewLevel,
  }) {
    return initBuildings(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GameInitBuildingsState value)? initBuildings,
    TResult? Function(_GameUpdateStatState value)? updateStat,
    TResult? Function(_GameOnNewLevelState value)? onNewLevel,
  }) {
    return initBuildings?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GameInitBuildingsState value)? initBuildings,
    TResult Function(_GameUpdateStatState value)? updateStat,
    TResult Function(_GameOnNewLevelState value)? onNewLevel,
    required TResult orElse(),
  }) {
    if (initBuildings != null) {
      return initBuildings(this);
    }
    return orElse();
  }
}

abstract class _GameInitBuildingsState implements GameState {
  const factory _GameInitBuildingsState(final GameStatistic gameStatistic,
      final List<BuildingEntity> buildinds) = _$GameInitBuildingsStateImpl;

  @override
  GameStatistic get gameStatistic;
  @override
  List<BuildingEntity> get buildinds;
  @override
  @JsonKey(ignore: true)
  _$$GameInitBuildingsStateImplCopyWith<_$GameInitBuildingsStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GameUpdateStatStateImplCopyWith<$Res>
    implements $GameStateCopyWith<$Res> {
  factory _$$GameUpdateStatStateImplCopyWith(_$GameUpdateStatStateImpl value,
          $Res Function(_$GameUpdateStatStateImpl) then) =
      __$$GameUpdateStatStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({GameStatistic gameStatistic, List<BuildingEntity> buildinds});
}

/// @nodoc
class __$$GameUpdateStatStateImplCopyWithImpl<$Res>
    extends _$GameStateCopyWithImpl<$Res, _$GameUpdateStatStateImpl>
    implements _$$GameUpdateStatStateImplCopyWith<$Res> {
  __$$GameUpdateStatStateImplCopyWithImpl(_$GameUpdateStatStateImpl _value,
      $Res Function(_$GameUpdateStatStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameStatistic = null,
    Object? buildinds = null,
  }) {
    return _then(_$GameUpdateStatStateImpl(
      null == gameStatistic
          ? _value.gameStatistic
          : gameStatistic // ignore: cast_nullable_to_non_nullable
              as GameStatistic,
      null == buildinds
          ? _value._buildinds
          : buildinds // ignore: cast_nullable_to_non_nullable
              as List<BuildingEntity>,
    ));
  }
}

/// @nodoc

class _$GameUpdateStatStateImpl implements _GameUpdateStatState {
  const _$GameUpdateStatStateImpl(
      this.gameStatistic, final List<BuildingEntity> buildinds)
      : _buildinds = buildinds;

  @override
  final GameStatistic gameStatistic;
  final List<BuildingEntity> _buildinds;
  @override
  List<BuildingEntity> get buildinds {
    if (_buildinds is EqualUnmodifiableListView) return _buildinds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_buildinds);
  }

  @override
  String toString() {
    return 'GameState.updateStat(gameStatistic: $gameStatistic, buildinds: $buildinds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameUpdateStatStateImpl &&
            (identical(other.gameStatistic, gameStatistic) ||
                other.gameStatistic == gameStatistic) &&
            const DeepCollectionEquality()
                .equals(other._buildinds, _buildinds));
  }

  @override
  int get hashCode => Object.hash(runtimeType, gameStatistic,
      const DeepCollectionEquality().hash(_buildinds));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameUpdateStatStateImplCopyWith<_$GameUpdateStatStateImpl> get copyWith =>
      __$$GameUpdateStatStateImplCopyWithImpl<_$GameUpdateStatStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            GameStatistic gameStatistic, List<BuildingEntity> buildinds)
        initBuildings,
    required TResult Function(
            GameStatistic gameStatistic, List<BuildingEntity> buildinds)
        updateStat,
    required TResult Function(GameStatistic gameStatistic,
            List<BuildingEntity> buildinds, int newLevel)
        onNewLevel,
  }) {
    return updateStat(gameStatistic, buildinds);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            GameStatistic gameStatistic, List<BuildingEntity> buildinds)?
        initBuildings,
    TResult? Function(
            GameStatistic gameStatistic, List<BuildingEntity> buildinds)?
        updateStat,
    TResult? Function(GameStatistic gameStatistic,
            List<BuildingEntity> buildinds, int newLevel)?
        onNewLevel,
  }) {
    return updateStat?.call(gameStatistic, buildinds);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            GameStatistic gameStatistic, List<BuildingEntity> buildinds)?
        initBuildings,
    TResult Function(
            GameStatistic gameStatistic, List<BuildingEntity> buildinds)?
        updateStat,
    TResult Function(GameStatistic gameStatistic,
            List<BuildingEntity> buildinds, int newLevel)?
        onNewLevel,
    required TResult orElse(),
  }) {
    if (updateStat != null) {
      return updateStat(gameStatistic, buildinds);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GameInitBuildingsState value) initBuildings,
    required TResult Function(_GameUpdateStatState value) updateStat,
    required TResult Function(_GameOnNewLevelState value) onNewLevel,
  }) {
    return updateStat(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GameInitBuildingsState value)? initBuildings,
    TResult? Function(_GameUpdateStatState value)? updateStat,
    TResult? Function(_GameOnNewLevelState value)? onNewLevel,
  }) {
    return updateStat?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GameInitBuildingsState value)? initBuildings,
    TResult Function(_GameUpdateStatState value)? updateStat,
    TResult Function(_GameOnNewLevelState value)? onNewLevel,
    required TResult orElse(),
  }) {
    if (updateStat != null) {
      return updateStat(this);
    }
    return orElse();
  }
}

abstract class _GameUpdateStatState implements GameState {
  const factory _GameUpdateStatState(final GameStatistic gameStatistic,
      final List<BuildingEntity> buildinds) = _$GameUpdateStatStateImpl;

  @override
  GameStatistic get gameStatistic;
  @override
  List<BuildingEntity> get buildinds;
  @override
  @JsonKey(ignore: true)
  _$$GameUpdateStatStateImplCopyWith<_$GameUpdateStatStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GameOnNewLevelStateImplCopyWith<$Res>
    implements $GameStateCopyWith<$Res> {
  factory _$$GameOnNewLevelStateImplCopyWith(_$GameOnNewLevelStateImpl value,
          $Res Function(_$GameOnNewLevelStateImpl) then) =
      __$$GameOnNewLevelStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {GameStatistic gameStatistic,
      List<BuildingEntity> buildinds,
      int newLevel});
}

/// @nodoc
class __$$GameOnNewLevelStateImplCopyWithImpl<$Res>
    extends _$GameStateCopyWithImpl<$Res, _$GameOnNewLevelStateImpl>
    implements _$$GameOnNewLevelStateImplCopyWith<$Res> {
  __$$GameOnNewLevelStateImplCopyWithImpl(_$GameOnNewLevelStateImpl _value,
      $Res Function(_$GameOnNewLevelStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameStatistic = null,
    Object? buildinds = null,
    Object? newLevel = null,
  }) {
    return _then(_$GameOnNewLevelStateImpl(
      null == gameStatistic
          ? _value.gameStatistic
          : gameStatistic // ignore: cast_nullable_to_non_nullable
              as GameStatistic,
      null == buildinds
          ? _value._buildinds
          : buildinds // ignore: cast_nullable_to_non_nullable
              as List<BuildingEntity>,
      null == newLevel
          ? _value.newLevel
          : newLevel // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$GameOnNewLevelStateImpl implements _GameOnNewLevelState {
  const _$GameOnNewLevelStateImpl(
      this.gameStatistic, final List<BuildingEntity> buildinds, this.newLevel)
      : _buildinds = buildinds;

  @override
  final GameStatistic gameStatistic;
  final List<BuildingEntity> _buildinds;
  @override
  List<BuildingEntity> get buildinds {
    if (_buildinds is EqualUnmodifiableListView) return _buildinds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_buildinds);
  }

  @override
  final int newLevel;

  @override
  String toString() {
    return 'GameState.onNewLevel(gameStatistic: $gameStatistic, buildinds: $buildinds, newLevel: $newLevel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameOnNewLevelStateImpl &&
            (identical(other.gameStatistic, gameStatistic) ||
                other.gameStatistic == gameStatistic) &&
            const DeepCollectionEquality()
                .equals(other._buildinds, _buildinds) &&
            (identical(other.newLevel, newLevel) ||
                other.newLevel == newLevel));
  }

  @override
  int get hashCode => Object.hash(runtimeType, gameStatistic,
      const DeepCollectionEquality().hash(_buildinds), newLevel);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameOnNewLevelStateImplCopyWith<_$GameOnNewLevelStateImpl> get copyWith =>
      __$$GameOnNewLevelStateImplCopyWithImpl<_$GameOnNewLevelStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            GameStatistic gameStatistic, List<BuildingEntity> buildinds)
        initBuildings,
    required TResult Function(
            GameStatistic gameStatistic, List<BuildingEntity> buildinds)
        updateStat,
    required TResult Function(GameStatistic gameStatistic,
            List<BuildingEntity> buildinds, int newLevel)
        onNewLevel,
  }) {
    return onNewLevel(gameStatistic, buildinds, newLevel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            GameStatistic gameStatistic, List<BuildingEntity> buildinds)?
        initBuildings,
    TResult? Function(
            GameStatistic gameStatistic, List<BuildingEntity> buildinds)?
        updateStat,
    TResult? Function(GameStatistic gameStatistic,
            List<BuildingEntity> buildinds, int newLevel)?
        onNewLevel,
  }) {
    return onNewLevel?.call(gameStatistic, buildinds, newLevel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            GameStatistic gameStatistic, List<BuildingEntity> buildinds)?
        initBuildings,
    TResult Function(
            GameStatistic gameStatistic, List<BuildingEntity> buildinds)?
        updateStat,
    TResult Function(GameStatistic gameStatistic,
            List<BuildingEntity> buildinds, int newLevel)?
        onNewLevel,
    required TResult orElse(),
  }) {
    if (onNewLevel != null) {
      return onNewLevel(gameStatistic, buildinds, newLevel);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GameInitBuildingsState value) initBuildings,
    required TResult Function(_GameUpdateStatState value) updateStat,
    required TResult Function(_GameOnNewLevelState value) onNewLevel,
  }) {
    return onNewLevel(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GameInitBuildingsState value)? initBuildings,
    TResult? Function(_GameUpdateStatState value)? updateStat,
    TResult? Function(_GameOnNewLevelState value)? onNewLevel,
  }) {
    return onNewLevel?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GameInitBuildingsState value)? initBuildings,
    TResult Function(_GameUpdateStatState value)? updateStat,
    TResult Function(_GameOnNewLevelState value)? onNewLevel,
    required TResult orElse(),
  }) {
    if (onNewLevel != null) {
      return onNewLevel(this);
    }
    return orElse();
  }
}

abstract class _GameOnNewLevelState implements GameState {
  const factory _GameOnNewLevelState(
      final GameStatistic gameStatistic,
      final List<BuildingEntity> buildinds,
      final int newLevel) = _$GameOnNewLevelStateImpl;

  @override
  GameStatistic get gameStatistic;
  @override
  List<BuildingEntity> get buildinds;
  int get newLevel;
  @override
  @JsonKey(ignore: true)
  _$$GameOnNewLevelStateImplCopyWith<_$GameOnNewLevelStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
