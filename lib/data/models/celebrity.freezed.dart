// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'celebrity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$CelebrityTearOff {
  const _$CelebrityTearOff();

  _Celebrity call(
      {required String name,
      required String photoUrl,
      required DateTime joinedDate,
      required bool isLive}) {
    return _Celebrity(
      name: name,
      photoUrl: photoUrl,
      joinedDate: joinedDate,
      isLive: isLive,
    );
  }
}

/// @nodoc
const $Celebrity = _$CelebrityTearOff();

/// @nodoc
mixin _$Celebrity {
  String get name => throw _privateConstructorUsedError;
  String get photoUrl => throw _privateConstructorUsedError;
  DateTime get joinedDate => throw _privateConstructorUsedError;
  bool get isLive => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CelebrityCopyWith<Celebrity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CelebrityCopyWith<$Res> {
  factory $CelebrityCopyWith(Celebrity value, $Res Function(Celebrity) then) =
      _$CelebrityCopyWithImpl<$Res>;
  $Res call({String name, String photoUrl, DateTime joinedDate, bool isLive});
}

/// @nodoc
class _$CelebrityCopyWithImpl<$Res> implements $CelebrityCopyWith<$Res> {
  _$CelebrityCopyWithImpl(this._value, this._then);

  final Celebrity _value;
  // ignore: unused_field
  final $Res Function(Celebrity) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? photoUrl = freezed,
    Object? joinedDate = freezed,
    Object? isLive = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      photoUrl: photoUrl == freezed
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      joinedDate: joinedDate == freezed
          ? _value.joinedDate
          : joinedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isLive: isLive == freezed
          ? _value.isLive
          : isLive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$CelebrityCopyWith<$Res> implements $CelebrityCopyWith<$Res> {
  factory _$CelebrityCopyWith(
          _Celebrity value, $Res Function(_Celebrity) then) =
      __$CelebrityCopyWithImpl<$Res>;
  @override
  $Res call({String name, String photoUrl, DateTime joinedDate, bool isLive});
}

/// @nodoc
class __$CelebrityCopyWithImpl<$Res> extends _$CelebrityCopyWithImpl<$Res>
    implements _$CelebrityCopyWith<$Res> {
  __$CelebrityCopyWithImpl(_Celebrity _value, $Res Function(_Celebrity) _then)
      : super(_value, (v) => _then(v as _Celebrity));

  @override
  _Celebrity get _value => super._value as _Celebrity;

  @override
  $Res call({
    Object? name = freezed,
    Object? photoUrl = freezed,
    Object? joinedDate = freezed,
    Object? isLive = freezed,
  }) {
    return _then(_Celebrity(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      photoUrl: photoUrl == freezed
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      joinedDate: joinedDate == freezed
          ? _value.joinedDate
          : joinedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isLive: isLive == freezed
          ? _value.isLive
          : isLive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
class _$_Celebrity implements _Celebrity {
  _$_Celebrity(
      {required this.name,
      required this.photoUrl,
      required this.joinedDate,
      required this.isLive});

  @override
  final String name;
  @override
  final String photoUrl;
  @override
  final DateTime joinedDate;
  @override
  final bool isLive;

  @override
  String toString() {
    return 'Celebrity(name: $name, photoUrl: $photoUrl, joinedDate: $joinedDate, isLive: $isLive)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Celebrity &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.photoUrl, photoUrl) ||
                const DeepCollectionEquality()
                    .equals(other.photoUrl, photoUrl)) &&
            (identical(other.joinedDate, joinedDate) ||
                const DeepCollectionEquality()
                    .equals(other.joinedDate, joinedDate)) &&
            (identical(other.isLive, isLive) ||
                const DeepCollectionEquality().equals(other.isLive, isLive)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(photoUrl) ^
      const DeepCollectionEquality().hash(joinedDate) ^
      const DeepCollectionEquality().hash(isLive);

  @JsonKey(ignore: true)
  @override
  _$CelebrityCopyWith<_Celebrity> get copyWith =>
      __$CelebrityCopyWithImpl<_Celebrity>(this, _$identity);
}

abstract class _Celebrity implements Celebrity {
  factory _Celebrity(
      {required String name,
      required String photoUrl,
      required DateTime joinedDate,
      required bool isLive}) = _$_Celebrity;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get photoUrl => throw _privateConstructorUsedError;
  @override
  DateTime get joinedDate => throw _privateConstructorUsedError;
  @override
  bool get isLive => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CelebrityCopyWith<_Celebrity> get copyWith =>
      throw _privateConstructorUsedError;
}
