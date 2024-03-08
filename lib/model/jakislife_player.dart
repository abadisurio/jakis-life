import 'package:freezed_annotation/freezed_annotation.dart';

part 'jakislife_player.freezed.dart';
part 'jakislife_player.g.dart';

@freezed
class JakisLifePlayer with _$JakisLifePlayer {
  @JsonSerializable(
    explicitToJson: true,
    includeIfNull: false,
    fieldRename: FieldRename.snake,
  )
  factory JakisLifePlayer({
    required String id,
    int? score,
    String? fcmToken,
    @JsonKey(defaultValue: false) bool? showOnePiece,
  }) = _JakisLifePlayer;

  factory JakisLifePlayer.fromJson(Map<String, dynamic> json) =>
      _$JakisLifePlayerFromJson(json);
}
