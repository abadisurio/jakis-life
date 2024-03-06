// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'jakislife_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

JakisLifeUser _$JakisLifeUserFromJson(Map<String, dynamic> json) {
  return _JakisLifeUser.fromJson(json);
}

/// @nodoc
mixin _$JakisLifeUser {
  String get id => throw _privateConstructorUsedError;
  int? get score => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: false)
  bool? get showOnePiece => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JakisLifeUserCopyWith<JakisLifeUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JakisLifeUserCopyWith<$Res> {
  factory $JakisLifeUserCopyWith(
          JakisLifeUser value, $Res Function(JakisLifeUser) then) =
      _$JakisLifeUserCopyWithImpl<$Res, JakisLifeUser>;
  @useResult
  $Res call(
      {String id,
      int? score,
      @JsonKey(defaultValue: false) bool? showOnePiece});
}

/// @nodoc
class _$JakisLifeUserCopyWithImpl<$Res, $Val extends JakisLifeUser>
    implements $JakisLifeUserCopyWith<$Res> {
  _$JakisLifeUserCopyWithImpl(this._value, this._then);

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
abstract class _$$JakisLifeUserImplCopyWith<$Res>
    implements $JakisLifeUserCopyWith<$Res> {
  factory _$$JakisLifeUserImplCopyWith(
          _$JakisLifeUserImpl value, $Res Function(_$JakisLifeUserImpl) then) =
      __$$JakisLifeUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      int? score,
      @JsonKey(defaultValue: false) bool? showOnePiece});
}

/// @nodoc
class __$$JakisLifeUserImplCopyWithImpl<$Res>
    extends _$JakisLifeUserCopyWithImpl<$Res, _$JakisLifeUserImpl>
    implements _$$JakisLifeUserImplCopyWith<$Res> {
  __$$JakisLifeUserImplCopyWithImpl(
      _$JakisLifeUserImpl _value, $Res Function(_$JakisLifeUserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? score = freezed,
    Object? showOnePiece = freezed,
  }) {
    return _then(_$JakisLifeUserImpl(
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
class _$JakisLifeUserImpl implements _JakisLifeUser {
  _$JakisLifeUserImpl(
      {required this.id,
      this.score,
      @JsonKey(defaultValue: false) this.showOnePiece});

  factory _$JakisLifeUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$JakisLifeUserImplFromJson(json);

  @override
  final String id;
  @override
  final int? score;
  @override
  @JsonKey(defaultValue: false)
  final bool? showOnePiece;

  @override
  String toString() {
    return 'JakisLifeUser(id: $id, score: $score, showOnePiece: $showOnePiece)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JakisLifeUserImpl &&
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
  _$$JakisLifeUserImplCopyWith<_$JakisLifeUserImpl> get copyWith =>
      __$$JakisLifeUserImplCopyWithImpl<_$JakisLifeUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JakisLifeUserImplToJson(
      this,
    );
  }
}

abstract class _JakisLifeUser implements JakisLifeUser {
  factory _JakisLifeUser(
          {required final String id,
          final int? score,
          @JsonKey(defaultValue: false) final bool? showOnePiece}) =
      _$JakisLifeUserImpl;

  factory _JakisLifeUser.fromJson(Map<String, dynamic> json) =
      _$JakisLifeUserImpl.fromJson;

  @override
  String get id;
  @override
  int? get score;
  @override
  @JsonKey(defaultValue: false)
  bool? get showOnePiece;
  @override
  @JsonKey(ignore: true)
  _$$JakisLifeUserImplCopyWith<_$JakisLifeUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
