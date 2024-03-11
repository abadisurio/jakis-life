import 'package:freezed_annotation/freezed_annotation.dart';

part 'jakislife_player.freezed.dart';
part 'jakislife_player.g.dart';

@freezed
class JakisLifePlayer with _$JakisLifePlayer {
  @JsonSerializable(
    explicitToJson: true,
    includeIfNull: false,
    fieldRename: FieldRename.none,
  )
  factory JakisLifePlayer({
    required String id,
    int? highScore,
    String? displayName,
    String? fcmToken,
    String? photoUrl,
  }) = _JakisLifePlayer;

  factory JakisLifePlayer.fromJson(Map<String, dynamic> json) =>
      _$JakisLifePlayerFromJson(json);
}
