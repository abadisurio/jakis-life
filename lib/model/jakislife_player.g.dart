// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jakislife_player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$JakisLifePlayerImpl _$$JakisLifePlayerImplFromJson(
        Map<String, dynamic> json) =>
    _$JakisLifePlayerImpl(
      id: json['id'] as String,
      highScore: json['highScore'] as int?,
      displayName: json['displayName'] as String?,
      fcmToken: json['fcmToken'] as String?,
      photoUrl: json['photoUrl'] as String?,
      playerState: json['playerState'] as String?,
      badgeSeries: json['badgeSeries'] as int?,
    );

Map<String, dynamic> _$$JakisLifePlayerImplToJson(
    _$JakisLifePlayerImpl instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('highScore', instance.highScore);
  writeNotNull('displayName', instance.displayName);
  writeNotNull('fcmToken', instance.fcmToken);
  writeNotNull('photoUrl', instance.photoUrl);
  writeNotNull('playerState', instance.playerState);
  writeNotNull('badgeSeries', instance.badgeSeries);
  return val;
}
