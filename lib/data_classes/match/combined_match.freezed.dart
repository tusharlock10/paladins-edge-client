// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'combined_match.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CombinedMatch {
  Match get match => throw _privateConstructorUsedError;
  List<MatchPlayer> get matchPlayers => throw _privateConstructorUsedError;
  bool get hide => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CombinedMatchCopyWith<CombinedMatch> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CombinedMatchCopyWith<$Res> {
  factory $CombinedMatchCopyWith(
          CombinedMatch value, $Res Function(CombinedMatch) then) =
      _$CombinedMatchCopyWithImpl<$Res, CombinedMatch>;
  @useResult
  $Res call({Match match, List<MatchPlayer> matchPlayers, bool hide});
}

/// @nodoc
class _$CombinedMatchCopyWithImpl<$Res, $Val extends CombinedMatch>
    implements $CombinedMatchCopyWith<$Res> {
  _$CombinedMatchCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? match = null,
    Object? matchPlayers = null,
    Object? hide = null,
  }) {
    return _then(_value.copyWith(
      match: null == match
          ? _value.match
          : match // ignore: cast_nullable_to_non_nullable
              as Match,
      matchPlayers: null == matchPlayers
          ? _value.matchPlayers
          : matchPlayers // ignore: cast_nullable_to_non_nullable
              as List<MatchPlayer>,
      hide: null == hide
          ? _value.hide
          : hide // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CombinedMatchImplCopyWith<$Res>
    implements $CombinedMatchCopyWith<$Res> {
  factory _$$CombinedMatchImplCopyWith(
          _$CombinedMatchImpl value, $Res Function(_$CombinedMatchImpl) then) =
      __$$CombinedMatchImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Match match, List<MatchPlayer> matchPlayers, bool hide});
}

/// @nodoc
class __$$CombinedMatchImplCopyWithImpl<$Res>
    extends _$CombinedMatchCopyWithImpl<$Res, _$CombinedMatchImpl>
    implements _$$CombinedMatchImplCopyWith<$Res> {
  __$$CombinedMatchImplCopyWithImpl(
      _$CombinedMatchImpl _value, $Res Function(_$CombinedMatchImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? match = null,
    Object? matchPlayers = null,
    Object? hide = null,
  }) {
    return _then(_$CombinedMatchImpl(
      match: null == match
          ? _value.match
          : match // ignore: cast_nullable_to_non_nullable
              as Match,
      matchPlayers: null == matchPlayers
          ? _value._matchPlayers
          : matchPlayers // ignore: cast_nullable_to_non_nullable
              as List<MatchPlayer>,
      hide: null == hide
          ? _value.hide
          : hide // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$CombinedMatchImpl implements _CombinedMatch {
  _$CombinedMatchImpl(
      {required this.match,
      required final List<MatchPlayer> matchPlayers,
      this.hide = false})
      : _matchPlayers = matchPlayers;

  @override
  final Match match;
  final List<MatchPlayer> _matchPlayers;
  @override
  List<MatchPlayer> get matchPlayers {
    if (_matchPlayers is EqualUnmodifiableListView) return _matchPlayers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_matchPlayers);
  }

  @override
  @JsonKey()
  final bool hide;

  @override
  String toString() {
    return 'CombinedMatch(match: $match, matchPlayers: $matchPlayers, hide: $hide)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CombinedMatchImpl &&
            (identical(other.match, match) || other.match == match) &&
            const DeepCollectionEquality()
                .equals(other._matchPlayers, _matchPlayers) &&
            (identical(other.hide, hide) || other.hide == hide));
  }

  @override
  int get hashCode => Object.hash(runtimeType, match,
      const DeepCollectionEquality().hash(_matchPlayers), hide);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CombinedMatchImplCopyWith<_$CombinedMatchImpl> get copyWith =>
      __$$CombinedMatchImplCopyWithImpl<_$CombinedMatchImpl>(this, _$identity);
}

abstract class _CombinedMatch implements CombinedMatch {
  factory _CombinedMatch(
      {required final Match match,
      required final List<MatchPlayer> matchPlayers,
      final bool hide}) = _$CombinedMatchImpl;

  @override
  Match get match;
  @override
  List<MatchPlayer> get matchPlayers;
  @override
  bool get hide;
  @override
  @JsonKey(ignore: true)
  _$$CombinedMatchImplCopyWith<_$CombinedMatchImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
