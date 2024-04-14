// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PlayerState _$PlayerStateFromJson(Map<String, dynamic> json) {
  return _PlayerState.fromJson(json);
}

/// @nodoc
mixin _$PlayerState {
  AuthState get authState => throw _privateConstructorUsedError;
  int get life => throw _privateConstructorUsedError;
  int get latestScore => throw _privateConstructorUsedError;
  int get highScore => throw _privateConstructorUsedError;
  JakisLifePlayer? get user => throw _privateConstructorUsedError;
  int? get badgeSeries => throw _privateConstructorUsedError;
  String? get currentGame => throw _privateConstructorUsedError;
  bool get isCurrentGameWin => throw _privateConstructorUsedError;
  bool get isMultiplayerUnlocked => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlayerStateCopyWith<PlayerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerStateCopyWith<$Res> {
  factory $PlayerStateCopyWith(
          PlayerState value, $Res Function(PlayerState) then) =
      _$PlayerStateCopyWithImpl<$Res, PlayerState>;
  @useResult
  $Res call(
      {AuthState authState,
      int life,
      int latestScore,
      int highScore,
      JakisLifePlayer? user,
      int? badgeSeries,
      String? currentGame,
      bool isCurrentGameWin,
      bool isMultiplayerUnlocked});

  $JakisLifePlayerCopyWith<$Res>? get user;
}

/// @nodoc
class _$PlayerStateCopyWithImpl<$Res, $Val extends PlayerState>
    implements $PlayerStateCopyWith<$Res> {
  _$PlayerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authState = null,
    Object? life = null,
    Object? latestScore = null,
    Object? highScore = null,
    Object? user = freezed,
    Object? badgeSeries = freezed,
    Object? currentGame = freezed,
    Object? isCurrentGameWin = null,
    Object? isMultiplayerUnlocked = null,
  }) {
    return _then(_value.copyWith(
      authState: null == authState
          ? _value.authState
          : authState // ignore: cast_nullable_to_non_nullable
              as AuthState,
      life: null == life
          ? _value.life
          : life // ignore: cast_nullable_to_non_nullable
              as int,
      latestScore: null == latestScore
          ? _value.latestScore
          : latestScore // ignore: cast_nullable_to_non_nullable
              as int,
      highScore: null == highScore
          ? _value.highScore
          : highScore // ignore: cast_nullable_to_non_nullable
              as int,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as JakisLifePlayer?,
      badgeSeries: freezed == badgeSeries
          ? _value.badgeSeries
          : badgeSeries // ignore: cast_nullable_to_non_nullable
              as int?,
      currentGame: freezed == currentGame
          ? _value.currentGame
          : currentGame // ignore: cast_nullable_to_non_nullable
              as String?,
      isCurrentGameWin: null == isCurrentGameWin
          ? _value.isCurrentGameWin
          : isCurrentGameWin // ignore: cast_nullable_to_non_nullable
              as bool,
      isMultiplayerUnlocked: null == isMultiplayerUnlocked
          ? _value.isMultiplayerUnlocked
          : isMultiplayerUnlocked // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $JakisLifePlayerCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $JakisLifePlayerCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PlayerStateImplCopyWith<$Res>
    implements $PlayerStateCopyWith<$Res> {
  factory _$$PlayerStateImplCopyWith(
          _$PlayerStateImpl value, $Res Function(_$PlayerStateImpl) then) =
      __$$PlayerStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AuthState authState,
      int life,
      int latestScore,
      int highScore,
      JakisLifePlayer? user,
      int? badgeSeries,
      String? currentGame,
      bool isCurrentGameWin,
      bool isMultiplayerUnlocked});

  @override
  $JakisLifePlayerCopyWith<$Res>? get user;
}

/// @nodoc
class __$$PlayerStateImplCopyWithImpl<$Res>
    extends _$PlayerStateCopyWithImpl<$Res, _$PlayerStateImpl>
    implements _$$PlayerStateImplCopyWith<$Res> {
  __$$PlayerStateImplCopyWithImpl(
      _$PlayerStateImpl _value, $Res Function(_$PlayerStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authState = null,
    Object? life = null,
    Object? latestScore = null,
    Object? highScore = null,
    Object? user = freezed,
    Object? badgeSeries = freezed,
    Object? currentGame = freezed,
    Object? isCurrentGameWin = null,
    Object? isMultiplayerUnlocked = null,
  }) {
    return _then(_$PlayerStateImpl(
      authState: null == authState
          ? _value.authState
          : authState // ignore: cast_nullable_to_non_nullable
              as AuthState,
      life: null == life
          ? _value.life
          : life // ignore: cast_nullable_to_non_nullable
              as int,
      latestScore: null == latestScore
          ? _value.latestScore
          : latestScore // ignore: cast_nullable_to_non_nullable
              as int,
      highScore: null == highScore
          ? _value.highScore
          : highScore // ignore: cast_nullable_to_non_nullable
              as int,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as JakisLifePlayer?,
      badgeSeries: freezed == badgeSeries
          ? _value.badgeSeries
          : badgeSeries // ignore: cast_nullable_to_non_nullable
              as int?,
      currentGame: freezed == currentGame
          ? _value.currentGame
          : currentGame // ignore: cast_nullable_to_non_nullable
              as String?,
      isCurrentGameWin: null == isCurrentGameWin
          ? _value.isCurrentGameWin
          : isCurrentGameWin // ignore: cast_nullable_to_non_nullable
              as bool,
      isMultiplayerUnlocked: null == isMultiplayerUnlocked
          ? _value.isMultiplayerUnlocked
          : isMultiplayerUnlocked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$PlayerStateImpl implements _PlayerState {
  const _$PlayerStateImpl(
      {this.authState = AuthState.loading,
      this.life = 3,
      this.latestScore = 0,
      this.highScore = 0,
      this.user,
      this.badgeSeries,
      this.currentGame,
      this.isCurrentGameWin = false,
      this.isMultiplayerUnlocked = false});

  factory _$PlayerStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlayerStateImplFromJson(json);

  @override
  @JsonKey()
  final AuthState authState;
  @override
  @JsonKey()
  final int life;
  @override
  @JsonKey()
  final int latestScore;
  @override
  @JsonKey()
  final int highScore;
  @override
  final JakisLifePlayer? user;
  @override
  final int? badgeSeries;
  @override
  final String? currentGame;
  @override
  @JsonKey()
  final bool isCurrentGameWin;
  @override
  @JsonKey()
  final bool isMultiplayerUnlocked;

  @override
  String toString() {
    return 'PlayerState(authState: $authState, life: $life, latestScore: $latestScore, highScore: $highScore, user: $user, badgeSeries: $badgeSeries, currentGame: $currentGame, isCurrentGameWin: $isCurrentGameWin, isMultiplayerUnlocked: $isMultiplayerUnlocked)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerStateImpl &&
            (identical(other.authState, authState) ||
                other.authState == authState) &&
            (identical(other.life, life) || other.life == life) &&
            (identical(other.latestScore, latestScore) ||
                other.latestScore == latestScore) &&
            (identical(other.highScore, highScore) ||
                other.highScore == highScore) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.badgeSeries, badgeSeries) ||
                other.badgeSeries == badgeSeries) &&
            (identical(other.currentGame, currentGame) ||
                other.currentGame == currentGame) &&
            (identical(other.isCurrentGameWin, isCurrentGameWin) ||
                other.isCurrentGameWin == isCurrentGameWin) &&
            (identical(other.isMultiplayerUnlocked, isMultiplayerUnlocked) ||
                other.isMultiplayerUnlocked == isMultiplayerUnlocked));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      authState,
      life,
      latestScore,
      highScore,
      user,
      badgeSeries,
      currentGame,
      isCurrentGameWin,
      isMultiplayerUnlocked);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerStateImplCopyWith<_$PlayerStateImpl> get copyWith =>
      __$$PlayerStateImplCopyWithImpl<_$PlayerStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlayerStateImplToJson(
      this,
    );
  }
}

abstract class _PlayerState implements PlayerState {
  const factory _PlayerState(
      {final AuthState authState,
      final int life,
      final int latestScore,
      final int highScore,
      final JakisLifePlayer? user,
      final int? badgeSeries,
      final String? currentGame,
      final bool isCurrentGameWin,
      final bool isMultiplayerUnlocked}) = _$PlayerStateImpl;

  factory _PlayerState.fromJson(Map<String, dynamic> json) =
      _$PlayerStateImpl.fromJson;

  @override
  AuthState get authState;
  @override
  int get life;
  @override
  int get latestScore;
  @override
  int get highScore;
  @override
  JakisLifePlayer? get user;
  @override
  int? get badgeSeries;
  @override
  String? get currentGame;
  @override
  bool get isCurrentGameWin;
  @override
  bool get isMultiplayerUnlocked;
  @override
  @JsonKey(ignore: true)
  _$$PlayerStateImplCopyWith<_$PlayerStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
