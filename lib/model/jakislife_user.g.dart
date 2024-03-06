// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jakislife_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$JakisLifeUserImpl _$$JakisLifeUserImplFromJson(Map<String, dynamic> json) =>
    _$JakisLifeUserImpl(
      id: json['id'] as String,
      score: json['score'] as int?,
      showOnePiece: json['show_one_piece'] as bool? ?? false,
    );

Map<String, dynamic> _$$JakisLifeUserImplToJson(_$JakisLifeUserImpl instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('score', instance.score);
  writeNotNull('show_one_piece', instance.showOnePiece);
  return val;
}
