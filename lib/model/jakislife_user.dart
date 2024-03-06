import 'package:freezed_annotation/freezed_annotation.dart';

part 'jakislife_user.freezed.dart';
part 'jakislife_user.g.dart';

@freezed
class JakisLifeUser with _$JakisLifeUser {
  @JsonSerializable(
    explicitToJson: true,
    includeIfNull: false,
    fieldRename: FieldRename.snake,
  )
  factory JakisLifeUser({
    required String id,
    int? score,
    @JsonKey(defaultValue: false) bool? showOnePiece,
  }) = _JakisLifeUser;

  factory JakisLifeUser.fromJson(Map<String, dynamic> json) =>
      _$JakisLifeUserFromJson(json);
}
