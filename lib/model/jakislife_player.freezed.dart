// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'jakislife_player.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

JakisLifePlayer _$JakisLifePlayerFromJson(Map<String, dynamic> json) {
  return _JakisLifePlayer.fromJson(json);
}

/// @nodoc
mixin _$JakisLifePlayer {
  String get id => throw _privateConstructorUsedError;
  int? get score => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: false)
  bool? get showOnePiece => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JakisLifePlayerCopyWith<JakisLifePlayer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JakisLifePlayerCopyWith<$Res> {
  factory $JakisLifePlayerCopyWith(
          JakisLifePlayer value, $Res Function(JakisLifePlayer) then) =
      _$JakisLifePlayerCopyWithImpl<$Res, JakisLifePlayer>;
  @useResult
  $Res call(
      {String id,
      int? score,
      @JsonKey(defaultValue: false) bool? showOnePiece});
}

/// @nodoc
class _$JakisLifePlayerCopyWithImpl<$Res, $Val extends JakisLifePlayer>
    implements $JakisLifePlayerCopyWith<$Res> {
  _$JakisLifePlayerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? score = freezed,
    Object? showOnePiece = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      score: freezed == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int?,
      showOnePiece: freezed == showOnePiece
          ? _value.showOnePiece
          : showOnePiece // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$JakisLifePlayerImplCopyWith<$Res>
    implements $JakisLifePlayerCopyWith<$Res> {
  factory _$$JakisLifePlayerImplCopyWith(_$JakisLifePlayerImpl value,
          $Res Function(_$JakisLifePlayerImpl) then) =
      __$$JakisLifePlayerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      int? score,
      @JsonKey(defaultValue: false) bool? showOnePiece});
}

/// @nodoc
class __$$JakisLifePlayerImplCopyWithImpl<$Res>
    extends _$JakisLifePlayerCopyWithImpl<$Res, _$JakisLifePlayerImpl>
    implements _$$JakisLifePlayerImplCopyWith<$Res> {
  __$$JakisLifePlayerImplCopyWithImpl(
      _$JakisLifePlayerImpl _value, $Res Function(_$JakisLifePlayerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? score = freezed,
    Object? showOnePiece = freezed,
  }) {
    return _then(_$JakisLifePlayerImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      score: freezed == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int?,
      showOnePiece: freezed == showOnePiece
          ? _value.showOnePiece
          : showOnePiece // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

@JsonSerializable(
    explicitToJson: true, includeIfNull: false, fieldRename: FieldRename.snake)
class _$JakisLifePlayerImpl implements _JakisLifePlayer {
  _$JakisLifePlayerImpl(
      {required this.id,
      this.score,
      @JsonKey(defaultValue: false) this.showOnePiece});

  factory _$JakisLifePlayerImpl.fromJson(Map<String, dynamic> json) =>
      _$$JakisLifePlayerImplFromJson(json);

  @override
  final String id;
  @override
  final int? score;
  @override
  @JsonKey(defaultValue: false)
  final bool? showOnePiece;

  @override
  String toString() {
    return 'JakisLifePlayer(id: $id, score: $score, showOnePiece: $showOnePiece)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JakisLifePlayerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.showOnePiece, showOnePiece) ||
                other.showOnePiece == showOnePiece));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, score, showOnePiece);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$JakisLifePlayerImplCopyWith<_$JakisLifePlayerImpl> get copyWith =>
      __$$JakisLifePlayerImplCopyWithImpl<_$JakisLifePlayerImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JakisLifePlayerImplToJson(
      this,
    );
  }
}

abstract class _JakisLifePlayer implements JakisLifePlayer {
  factory _JakisLifePlayer(
          {required final String id,
          final int? score,
          @JsonKey(defaultValue: false) final bool? showOnePiece}) =
      _$JakisLifePlayerImpl;

  factory _JakisLifePlayer.fromJson(Map<String, dynamic> json) =
      _$JakisLifePlayerImpl.fromJson;

  @override
  String get id;
  @override
  int? get score;
  @override
  @JsonKey(defaultValue: false)
  bool? get showOnePiece;
  @override
  @JsonKey(ignore: true)
  _$$JakisLifePlayerImplCopyWith<_$JakisLifePlayerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
