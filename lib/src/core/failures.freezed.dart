// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failures.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ValueFailure<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unexpected,
    required TResult Function(String message) limitExceedMaxWordsFetch,
    required TResult Function(String message) limitNotUpToMinimum,
    required TResult Function(String message) offsetNotUpToMinimum,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unexpected,
    TResult? Function(String message)? limitExceedMaxWordsFetch,
    TResult? Function(String message)? limitNotUpToMinimum,
    TResult? Function(String message)? offsetNotUpToMinimum,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unexpected,
    TResult Function(String message)? limitExceedMaxWordsFetch,
    TResult Function(String message)? limitNotUpToMinimum,
    TResult Function(String message)? offsetNotUpToMinimum,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UnexpectedFailure<T> value) unexpected,
    required TResult Function(_LimitExceedMaxWordsFetchFailure<T> value)
        limitExceedMaxWordsFetch,
    required TResult Function(_LimitNotUpToMinimumFailure<T> value)
        limitNotUpToMinimum,
    required TResult Function(_OffsetNotUpToMinimumFailure<T> value)
        offsetNotUpToMinimum,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UnexpectedFailure<T> value)? unexpected,
    TResult? Function(_LimitExceedMaxWordsFetchFailure<T> value)?
        limitExceedMaxWordsFetch,
    TResult? Function(_LimitNotUpToMinimumFailure<T> value)?
        limitNotUpToMinimum,
    TResult? Function(_OffsetNotUpToMinimumFailure<T> value)?
        offsetNotUpToMinimum,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UnexpectedFailure<T> value)? unexpected,
    TResult Function(_LimitExceedMaxWordsFetchFailure<T> value)?
        limitExceedMaxWordsFetch,
    TResult Function(_LimitNotUpToMinimumFailure<T> value)? limitNotUpToMinimum,
    TResult Function(_OffsetNotUpToMinimumFailure<T> value)?
        offsetNotUpToMinimum,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ValueFailureCopyWith<T, $Res> {
  factory $ValueFailureCopyWith(
          ValueFailure<T> value, $Res Function(ValueFailure<T>) then) =
      _$ValueFailureCopyWithImpl<T, $Res, ValueFailure<T>>;
}

/// @nodoc
class _$ValueFailureCopyWithImpl<T, $Res, $Val extends ValueFailure<T>>
    implements $ValueFailureCopyWith<T, $Res> {
  _$ValueFailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_UnexpectedFailureCopyWith<T, $Res> {
  factory _$$_UnexpectedFailureCopyWith(_$_UnexpectedFailure<T> value,
          $Res Function(_$_UnexpectedFailure<T>) then) =
      __$$_UnexpectedFailureCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$_UnexpectedFailureCopyWithImpl<T, $Res>
    extends _$ValueFailureCopyWithImpl<T, $Res, _$_UnexpectedFailure<T>>
    implements _$$_UnexpectedFailureCopyWith<T, $Res> {
  __$$_UnexpectedFailureCopyWithImpl(_$_UnexpectedFailure<T> _value,
      $Res Function(_$_UnexpectedFailure<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_UnexpectedFailure<T> implements _UnexpectedFailure<T> {
  const _$_UnexpectedFailure();

  @override
  String toString() {
    return 'ValueFailure<$T>.unexpected()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_UnexpectedFailure<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unexpected,
    required TResult Function(String message) limitExceedMaxWordsFetch,
    required TResult Function(String message) limitNotUpToMinimum,
    required TResult Function(String message) offsetNotUpToMinimum,
  }) {
    return unexpected();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unexpected,
    TResult? Function(String message)? limitExceedMaxWordsFetch,
    TResult? Function(String message)? limitNotUpToMinimum,
    TResult? Function(String message)? offsetNotUpToMinimum,
  }) {
    return unexpected?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unexpected,
    TResult Function(String message)? limitExceedMaxWordsFetch,
    TResult Function(String message)? limitNotUpToMinimum,
    TResult Function(String message)? offsetNotUpToMinimum,
    required TResult orElse(),
  }) {
    if (unexpected != null) {
      return unexpected();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UnexpectedFailure<T> value) unexpected,
    required TResult Function(_LimitExceedMaxWordsFetchFailure<T> value)
        limitExceedMaxWordsFetch,
    required TResult Function(_LimitNotUpToMinimumFailure<T> value)
        limitNotUpToMinimum,
    required TResult Function(_OffsetNotUpToMinimumFailure<T> value)
        offsetNotUpToMinimum,
  }) {
    return unexpected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UnexpectedFailure<T> value)? unexpected,
    TResult? Function(_LimitExceedMaxWordsFetchFailure<T> value)?
        limitExceedMaxWordsFetch,
    TResult? Function(_LimitNotUpToMinimumFailure<T> value)?
        limitNotUpToMinimum,
    TResult? Function(_OffsetNotUpToMinimumFailure<T> value)?
        offsetNotUpToMinimum,
  }) {
    return unexpected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UnexpectedFailure<T> value)? unexpected,
    TResult Function(_LimitExceedMaxWordsFetchFailure<T> value)?
        limitExceedMaxWordsFetch,
    TResult Function(_LimitNotUpToMinimumFailure<T> value)? limitNotUpToMinimum,
    TResult Function(_OffsetNotUpToMinimumFailure<T> value)?
        offsetNotUpToMinimum,
    required TResult orElse(),
  }) {
    if (unexpected != null) {
      return unexpected(this);
    }
    return orElse();
  }
}

abstract class _UnexpectedFailure<T> implements ValueFailure<T> {
  const factory _UnexpectedFailure() = _$_UnexpectedFailure<T>;
}

/// @nodoc
abstract class _$$_LimitExceedMaxWordsFetchFailureCopyWith<T, $Res> {
  factory _$$_LimitExceedMaxWordsFetchFailureCopyWith(
          _$_LimitExceedMaxWordsFetchFailure<T> value,
          $Res Function(_$_LimitExceedMaxWordsFetchFailure<T>) then) =
      __$$_LimitExceedMaxWordsFetchFailureCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$_LimitExceedMaxWordsFetchFailureCopyWithImpl<T, $Res>
    extends _$ValueFailureCopyWithImpl<T, $Res,
        _$_LimitExceedMaxWordsFetchFailure<T>>
    implements _$$_LimitExceedMaxWordsFetchFailureCopyWith<T, $Res> {
  __$$_LimitExceedMaxWordsFetchFailureCopyWithImpl(
      _$_LimitExceedMaxWordsFetchFailure<T> _value,
      $Res Function(_$_LimitExceedMaxWordsFetchFailure<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$_LimitExceedMaxWordsFetchFailure<T>(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_LimitExceedMaxWordsFetchFailure<T>
    implements _LimitExceedMaxWordsFetchFailure<T> {
  const _$_LimitExceedMaxWordsFetchFailure(
      {this.message = "Limit exceeds ${AppConstants.maxWordsFetchLimit}"});

  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'ValueFailure<$T>.limitExceedMaxWordsFetch(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LimitExceedMaxWordsFetchFailure<T> &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LimitExceedMaxWordsFetchFailureCopyWith<T,
          _$_LimitExceedMaxWordsFetchFailure<T>>
      get copyWith => __$$_LimitExceedMaxWordsFetchFailureCopyWithImpl<T,
          _$_LimitExceedMaxWordsFetchFailure<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unexpected,
    required TResult Function(String message) limitExceedMaxWordsFetch,
    required TResult Function(String message) limitNotUpToMinimum,
    required TResult Function(String message) offsetNotUpToMinimum,
  }) {
    return limitExceedMaxWordsFetch(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unexpected,
    TResult? Function(String message)? limitExceedMaxWordsFetch,
    TResult? Function(String message)? limitNotUpToMinimum,
    TResult? Function(String message)? offsetNotUpToMinimum,
  }) {
    return limitExceedMaxWordsFetch?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unexpected,
    TResult Function(String message)? limitExceedMaxWordsFetch,
    TResult Function(String message)? limitNotUpToMinimum,
    TResult Function(String message)? offsetNotUpToMinimum,
    required TResult orElse(),
  }) {
    if (limitExceedMaxWordsFetch != null) {
      return limitExceedMaxWordsFetch(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UnexpectedFailure<T> value) unexpected,
    required TResult Function(_LimitExceedMaxWordsFetchFailure<T> value)
        limitExceedMaxWordsFetch,
    required TResult Function(_LimitNotUpToMinimumFailure<T> value)
        limitNotUpToMinimum,
    required TResult Function(_OffsetNotUpToMinimumFailure<T> value)
        offsetNotUpToMinimum,
  }) {
    return limitExceedMaxWordsFetch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UnexpectedFailure<T> value)? unexpected,
    TResult? Function(_LimitExceedMaxWordsFetchFailure<T> value)?
        limitExceedMaxWordsFetch,
    TResult? Function(_LimitNotUpToMinimumFailure<T> value)?
        limitNotUpToMinimum,
    TResult? Function(_OffsetNotUpToMinimumFailure<T> value)?
        offsetNotUpToMinimum,
  }) {
    return limitExceedMaxWordsFetch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UnexpectedFailure<T> value)? unexpected,
    TResult Function(_LimitExceedMaxWordsFetchFailure<T> value)?
        limitExceedMaxWordsFetch,
    TResult Function(_LimitNotUpToMinimumFailure<T> value)? limitNotUpToMinimum,
    TResult Function(_OffsetNotUpToMinimumFailure<T> value)?
        offsetNotUpToMinimum,
    required TResult orElse(),
  }) {
    if (limitExceedMaxWordsFetch != null) {
      return limitExceedMaxWordsFetch(this);
    }
    return orElse();
  }
}

abstract class _LimitExceedMaxWordsFetchFailure<T> implements ValueFailure<T> {
  const factory _LimitExceedMaxWordsFetchFailure({final String message}) =
      _$_LimitExceedMaxWordsFetchFailure<T>;

  String get message;
  @JsonKey(ignore: true)
  _$$_LimitExceedMaxWordsFetchFailureCopyWith<T,
          _$_LimitExceedMaxWordsFetchFailure<T>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_LimitNotUpToMinimumFailureCopyWith<T, $Res> {
  factory _$$_LimitNotUpToMinimumFailureCopyWith(
          _$_LimitNotUpToMinimumFailure<T> value,
          $Res Function(_$_LimitNotUpToMinimumFailure<T>) then) =
      __$$_LimitNotUpToMinimumFailureCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$_LimitNotUpToMinimumFailureCopyWithImpl<T, $Res>
    extends _$ValueFailureCopyWithImpl<T, $Res,
        _$_LimitNotUpToMinimumFailure<T>>
    implements _$$_LimitNotUpToMinimumFailureCopyWith<T, $Res> {
  __$$_LimitNotUpToMinimumFailureCopyWithImpl(
      _$_LimitNotUpToMinimumFailure<T> _value,
      $Res Function(_$_LimitNotUpToMinimumFailure<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$_LimitNotUpToMinimumFailure<T>(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_LimitNotUpToMinimumFailure<T>
    implements _LimitNotUpToMinimumFailure<T> {
  const _$_LimitNotUpToMinimumFailure(
      {this.message = "Limit is not up to ${AppConstants.minWordsFetchLimit}"});

  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'ValueFailure<$T>.limitNotUpToMinimum(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LimitNotUpToMinimumFailure<T> &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LimitNotUpToMinimumFailureCopyWith<T, _$_LimitNotUpToMinimumFailure<T>>
      get copyWith => __$$_LimitNotUpToMinimumFailureCopyWithImpl<T,
          _$_LimitNotUpToMinimumFailure<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unexpected,
    required TResult Function(String message) limitExceedMaxWordsFetch,
    required TResult Function(String message) limitNotUpToMinimum,
    required TResult Function(String message) offsetNotUpToMinimum,
  }) {
    return limitNotUpToMinimum(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unexpected,
    TResult? Function(String message)? limitExceedMaxWordsFetch,
    TResult? Function(String message)? limitNotUpToMinimum,
    TResult? Function(String message)? offsetNotUpToMinimum,
  }) {
    return limitNotUpToMinimum?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unexpected,
    TResult Function(String message)? limitExceedMaxWordsFetch,
    TResult Function(String message)? limitNotUpToMinimum,
    TResult Function(String message)? offsetNotUpToMinimum,
    required TResult orElse(),
  }) {
    if (limitNotUpToMinimum != null) {
      return limitNotUpToMinimum(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UnexpectedFailure<T> value) unexpected,
    required TResult Function(_LimitExceedMaxWordsFetchFailure<T> value)
        limitExceedMaxWordsFetch,
    required TResult Function(_LimitNotUpToMinimumFailure<T> value)
        limitNotUpToMinimum,
    required TResult Function(_OffsetNotUpToMinimumFailure<T> value)
        offsetNotUpToMinimum,
  }) {
    return limitNotUpToMinimum(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UnexpectedFailure<T> value)? unexpected,
    TResult? Function(_LimitExceedMaxWordsFetchFailure<T> value)?
        limitExceedMaxWordsFetch,
    TResult? Function(_LimitNotUpToMinimumFailure<T> value)?
        limitNotUpToMinimum,
    TResult? Function(_OffsetNotUpToMinimumFailure<T> value)?
        offsetNotUpToMinimum,
  }) {
    return limitNotUpToMinimum?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UnexpectedFailure<T> value)? unexpected,
    TResult Function(_LimitExceedMaxWordsFetchFailure<T> value)?
        limitExceedMaxWordsFetch,
    TResult Function(_LimitNotUpToMinimumFailure<T> value)? limitNotUpToMinimum,
    TResult Function(_OffsetNotUpToMinimumFailure<T> value)?
        offsetNotUpToMinimum,
    required TResult orElse(),
  }) {
    if (limitNotUpToMinimum != null) {
      return limitNotUpToMinimum(this);
    }
    return orElse();
  }
}

abstract class _LimitNotUpToMinimumFailure<T> implements ValueFailure<T> {
  const factory _LimitNotUpToMinimumFailure({final String message}) =
      _$_LimitNotUpToMinimumFailure<T>;

  String get message;
  @JsonKey(ignore: true)
  _$$_LimitNotUpToMinimumFailureCopyWith<T, _$_LimitNotUpToMinimumFailure<T>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_OffsetNotUpToMinimumFailureCopyWith<T, $Res> {
  factory _$$_OffsetNotUpToMinimumFailureCopyWith(
          _$_OffsetNotUpToMinimumFailure<T> value,
          $Res Function(_$_OffsetNotUpToMinimumFailure<T>) then) =
      __$$_OffsetNotUpToMinimumFailureCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$_OffsetNotUpToMinimumFailureCopyWithImpl<T, $Res>
    extends _$ValueFailureCopyWithImpl<T, $Res,
        _$_OffsetNotUpToMinimumFailure<T>>
    implements _$$_OffsetNotUpToMinimumFailureCopyWith<T, $Res> {
  __$$_OffsetNotUpToMinimumFailureCopyWithImpl(
      _$_OffsetNotUpToMinimumFailure<T> _value,
      $Res Function(_$_OffsetNotUpToMinimumFailure<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$_OffsetNotUpToMinimumFailure<T>(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_OffsetNotUpToMinimumFailure<T>
    implements _OffsetNotUpToMinimumFailure<T> {
  const _$_OffsetNotUpToMinimumFailure(
      {this.message = "Offset cannot be negative"});

  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'ValueFailure<$T>.offsetNotUpToMinimum(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OffsetNotUpToMinimumFailure<T> &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OffsetNotUpToMinimumFailureCopyWith<T, _$_OffsetNotUpToMinimumFailure<T>>
      get copyWith => __$$_OffsetNotUpToMinimumFailureCopyWithImpl<T,
          _$_OffsetNotUpToMinimumFailure<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unexpected,
    required TResult Function(String message) limitExceedMaxWordsFetch,
    required TResult Function(String message) limitNotUpToMinimum,
    required TResult Function(String message) offsetNotUpToMinimum,
  }) {
    return offsetNotUpToMinimum(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unexpected,
    TResult? Function(String message)? limitExceedMaxWordsFetch,
    TResult? Function(String message)? limitNotUpToMinimum,
    TResult? Function(String message)? offsetNotUpToMinimum,
  }) {
    return offsetNotUpToMinimum?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unexpected,
    TResult Function(String message)? limitExceedMaxWordsFetch,
    TResult Function(String message)? limitNotUpToMinimum,
    TResult Function(String message)? offsetNotUpToMinimum,
    required TResult orElse(),
  }) {
    if (offsetNotUpToMinimum != null) {
      return offsetNotUpToMinimum(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UnexpectedFailure<T> value) unexpected,
    required TResult Function(_LimitExceedMaxWordsFetchFailure<T> value)
        limitExceedMaxWordsFetch,
    required TResult Function(_LimitNotUpToMinimumFailure<T> value)
        limitNotUpToMinimum,
    required TResult Function(_OffsetNotUpToMinimumFailure<T> value)
        offsetNotUpToMinimum,
  }) {
    return offsetNotUpToMinimum(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UnexpectedFailure<T> value)? unexpected,
    TResult? Function(_LimitExceedMaxWordsFetchFailure<T> value)?
        limitExceedMaxWordsFetch,
    TResult? Function(_LimitNotUpToMinimumFailure<T> value)?
        limitNotUpToMinimum,
    TResult? Function(_OffsetNotUpToMinimumFailure<T> value)?
        offsetNotUpToMinimum,
  }) {
    return offsetNotUpToMinimum?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UnexpectedFailure<T> value)? unexpected,
    TResult Function(_LimitExceedMaxWordsFetchFailure<T> value)?
        limitExceedMaxWordsFetch,
    TResult Function(_LimitNotUpToMinimumFailure<T> value)? limitNotUpToMinimum,
    TResult Function(_OffsetNotUpToMinimumFailure<T> value)?
        offsetNotUpToMinimum,
    required TResult orElse(),
  }) {
    if (offsetNotUpToMinimum != null) {
      return offsetNotUpToMinimum(this);
    }
    return orElse();
  }
}

abstract class _OffsetNotUpToMinimumFailure<T> implements ValueFailure<T> {
  const factory _OffsetNotUpToMinimumFailure({final String message}) =
      _$_OffsetNotUpToMinimumFailure<T>;

  String get message;
  @JsonKey(ignore: true)
  _$$_OffsetNotUpToMinimumFailureCopyWith<T, _$_OffsetNotUpToMinimumFailure<T>>
      get copyWith => throw _privateConstructorUsedError;
}
