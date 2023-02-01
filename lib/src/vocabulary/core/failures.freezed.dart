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
mixin _$VocabularyFailure {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) unexpected,
    required TResult Function() unableToParseCSV,
    required TResult Function(String message) valueError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? unexpected,
    TResult? Function()? unableToParseCSV,
    TResult? Function(String message)? valueError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? unexpected,
    TResult Function()? unableToParseCSV,
    TResult Function(String message)? valueError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UnexpectedFailure value) unexpected,
    required TResult Function(_UnableToParseCSVFailure value) unableToParseCSV,
    required TResult Function(_VocabularyValueError value) valueError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UnexpectedFailure value)? unexpected,
    TResult? Function(_UnableToParseCSVFailure value)? unableToParseCSV,
    TResult? Function(_VocabularyValueError value)? valueError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UnexpectedFailure value)? unexpected,
    TResult Function(_UnableToParseCSVFailure value)? unableToParseCSV,
    TResult Function(_VocabularyValueError value)? valueError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VocabularyFailureCopyWith<$Res> {
  factory $VocabularyFailureCopyWith(
          VocabularyFailure value, $Res Function(VocabularyFailure) then) =
      _$VocabularyFailureCopyWithImpl<$Res, VocabularyFailure>;
}

/// @nodoc
class _$VocabularyFailureCopyWithImpl<$Res, $Val extends VocabularyFailure>
    implements $VocabularyFailureCopyWith<$Res> {
  _$VocabularyFailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_UnexpectedFailureCopyWith<$Res> {
  factory _$$_UnexpectedFailureCopyWith(_$_UnexpectedFailure value,
          $Res Function(_$_UnexpectedFailure) then) =
      __$$_UnexpectedFailureCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$_UnexpectedFailureCopyWithImpl<$Res>
    extends _$VocabularyFailureCopyWithImpl<$Res, _$_UnexpectedFailure>
    implements _$$_UnexpectedFailureCopyWith<$Res> {
  __$$_UnexpectedFailureCopyWithImpl(
      _$_UnexpectedFailure _value, $Res Function(_$_UnexpectedFailure) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$_UnexpectedFailure(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_UnexpectedFailure extends _UnexpectedFailure {
  const _$_UnexpectedFailure({this.message = 'Some error occurred'})
      : super._();

  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'VocabularyFailure.unexpected(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UnexpectedFailure &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UnexpectedFailureCopyWith<_$_UnexpectedFailure> get copyWith =>
      __$$_UnexpectedFailureCopyWithImpl<_$_UnexpectedFailure>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) unexpected,
    required TResult Function() unableToParseCSV,
    required TResult Function(String message) valueError,
  }) {
    return unexpected(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? unexpected,
    TResult? Function()? unableToParseCSV,
    TResult? Function(String message)? valueError,
  }) {
    return unexpected?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? unexpected,
    TResult Function()? unableToParseCSV,
    TResult Function(String message)? valueError,
    required TResult orElse(),
  }) {
    if (unexpected != null) {
      return unexpected(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UnexpectedFailure value) unexpected,
    required TResult Function(_UnableToParseCSVFailure value) unableToParseCSV,
    required TResult Function(_VocabularyValueError value) valueError,
  }) {
    return unexpected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UnexpectedFailure value)? unexpected,
    TResult? Function(_UnableToParseCSVFailure value)? unableToParseCSV,
    TResult? Function(_VocabularyValueError value)? valueError,
  }) {
    return unexpected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UnexpectedFailure value)? unexpected,
    TResult Function(_UnableToParseCSVFailure value)? unableToParseCSV,
    TResult Function(_VocabularyValueError value)? valueError,
    required TResult orElse(),
  }) {
    if (unexpected != null) {
      return unexpected(this);
    }
    return orElse();
  }
}

abstract class _UnexpectedFailure extends VocabularyFailure {
  const factory _UnexpectedFailure({final String message}) =
      _$_UnexpectedFailure;
  const _UnexpectedFailure._() : super._();

  String get message;
  @JsonKey(ignore: true)
  _$$_UnexpectedFailureCopyWith<_$_UnexpectedFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_UnableToParseCSVFailureCopyWith<$Res> {
  factory _$$_UnableToParseCSVFailureCopyWith(_$_UnableToParseCSVFailure value,
          $Res Function(_$_UnableToParseCSVFailure) then) =
      __$$_UnableToParseCSVFailureCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_UnableToParseCSVFailureCopyWithImpl<$Res>
    extends _$VocabularyFailureCopyWithImpl<$Res, _$_UnableToParseCSVFailure>
    implements _$$_UnableToParseCSVFailureCopyWith<$Res> {
  __$$_UnableToParseCSVFailureCopyWithImpl(_$_UnableToParseCSVFailure _value,
      $Res Function(_$_UnableToParseCSVFailure) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_UnableToParseCSVFailure extends _UnableToParseCSVFailure {
  const _$_UnableToParseCSVFailure() : super._();

  @override
  String toString() {
    return 'VocabularyFailure.unableToParseCSV()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UnableToParseCSVFailure);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) unexpected,
    required TResult Function() unableToParseCSV,
    required TResult Function(String message) valueError,
  }) {
    return unableToParseCSV();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? unexpected,
    TResult? Function()? unableToParseCSV,
    TResult? Function(String message)? valueError,
  }) {
    return unableToParseCSV?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? unexpected,
    TResult Function()? unableToParseCSV,
    TResult Function(String message)? valueError,
    required TResult orElse(),
  }) {
    if (unableToParseCSV != null) {
      return unableToParseCSV();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UnexpectedFailure value) unexpected,
    required TResult Function(_UnableToParseCSVFailure value) unableToParseCSV,
    required TResult Function(_VocabularyValueError value) valueError,
  }) {
    return unableToParseCSV(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UnexpectedFailure value)? unexpected,
    TResult? Function(_UnableToParseCSVFailure value)? unableToParseCSV,
    TResult? Function(_VocabularyValueError value)? valueError,
  }) {
    return unableToParseCSV?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UnexpectedFailure value)? unexpected,
    TResult Function(_UnableToParseCSVFailure value)? unableToParseCSV,
    TResult Function(_VocabularyValueError value)? valueError,
    required TResult orElse(),
  }) {
    if (unableToParseCSV != null) {
      return unableToParseCSV(this);
    }
    return orElse();
  }
}

abstract class _UnableToParseCSVFailure extends VocabularyFailure {
  const factory _UnableToParseCSVFailure() = _$_UnableToParseCSVFailure;
  const _UnableToParseCSVFailure._() : super._();
}

/// @nodoc
abstract class _$$_VocabularyValueErrorCopyWith<$Res> {
  factory _$$_VocabularyValueErrorCopyWith(_$_VocabularyValueError value,
          $Res Function(_$_VocabularyValueError) then) =
      __$$_VocabularyValueErrorCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$_VocabularyValueErrorCopyWithImpl<$Res>
    extends _$VocabularyFailureCopyWithImpl<$Res, _$_VocabularyValueError>
    implements _$$_VocabularyValueErrorCopyWith<$Res> {
  __$$_VocabularyValueErrorCopyWithImpl(_$_VocabularyValueError _value,
      $Res Function(_$_VocabularyValueError) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$_VocabularyValueError(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_VocabularyValueError extends _VocabularyValueError {
  const _$_VocabularyValueError({required this.message}) : super._();

  @override
  final String message;

  @override
  String toString() {
    return 'VocabularyFailure.valueError(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VocabularyValueError &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_VocabularyValueErrorCopyWith<_$_VocabularyValueError> get copyWith =>
      __$$_VocabularyValueErrorCopyWithImpl<_$_VocabularyValueError>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) unexpected,
    required TResult Function() unableToParseCSV,
    required TResult Function(String message) valueError,
  }) {
    return valueError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? unexpected,
    TResult? Function()? unableToParseCSV,
    TResult? Function(String message)? valueError,
  }) {
    return valueError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? unexpected,
    TResult Function()? unableToParseCSV,
    TResult Function(String message)? valueError,
    required TResult orElse(),
  }) {
    if (valueError != null) {
      return valueError(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UnexpectedFailure value) unexpected,
    required TResult Function(_UnableToParseCSVFailure value) unableToParseCSV,
    required TResult Function(_VocabularyValueError value) valueError,
  }) {
    return valueError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UnexpectedFailure value)? unexpected,
    TResult? Function(_UnableToParseCSVFailure value)? unableToParseCSV,
    TResult? Function(_VocabularyValueError value)? valueError,
  }) {
    return valueError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UnexpectedFailure value)? unexpected,
    TResult Function(_UnableToParseCSVFailure value)? unableToParseCSV,
    TResult Function(_VocabularyValueError value)? valueError,
    required TResult orElse(),
  }) {
    if (valueError != null) {
      return valueError(this);
    }
    return orElse();
  }
}

abstract class _VocabularyValueError extends VocabularyFailure {
  const factory _VocabularyValueError({required final String message}) =
      _$_VocabularyValueError;
  const _VocabularyValueError._() : super._();

  String get message;
  @JsonKey(ignore: true)
  _$$_VocabularyValueErrorCopyWith<_$_VocabularyValueError> get copyWith =>
      throw _privateConstructorUsedError;
}
