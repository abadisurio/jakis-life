// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlayerStateImpl _$$PlayerStateImplFromJson(Map<String, dynamic> json) =>
    _$PlayerStateImpl(
      authState: $enumDecodeNullable(_$AuthStateEnumMap, json['authState']) ??
          AuthState.loading,
      life: json['life'] as int? ?? 3,
      latestScore: json['latestScore'] as int? ?? 0,
      highScore: json['highScore'] as int? ?? 0,
      user: json['user'] == null
          ? null
          : JakisLifePlayer.fromJson(json['user'] as Map<String, dynamic>),
      badgeSeries: json['badgeSeries'] as int?,
      currentGame: json['currentGame'] as String?,
      isCurrentGameWin: json['isCurrentGameWin'] as bool? ?? false,
      isMultiplayerUnlocked: json['isMultiplayerUnlocked'] as bool? ?? false,
    );

Map<String, dynamic> _$$PlayerStateImplToJson(_$PlayerStateImpl instance) =>
    <String, dynamic>{
      'authState': _$AuthStateEnumMap[instance.authState]!,
      'life': instance.life,
      'latestScore': instance.latestScore,
      'highScore': instance.highScore,
      'user': instance.user?.toJson(),
      'badgeSeries': instance.badgeSeries,
      'currentGame': instance.currentGame,
      'isCurrentGameWin': instance.isCurrentGameWin,
      'isMultiplayerUnlocked': instance.isMultiplayerUnlocked,
    };

const _$AuthStateEnumMap = {
  AuthState.signedIn: 'signedIn',
  AuthState.loading: 'loading',
  AuthState.signedOut: 'signedOut',
};
