// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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
      _$CombinedMatchCopyWithImpl<$Res>;
  $Res call({Match match, List<MatchPlayer> matchPlayers, bool hide});
}

/// @nodoc
class _$CombinedMatchCopyWithImpl<$Res>
    implements $CombinedMatchCopyWith<$Res> {
  _$CombinedMatchCopyWithImpl(this._value, this._then);

  final CombinedMatch _value;
  // ignore: unused_field
  final $Res Function(CombinedMatch) _then;

  @override
  $Res call({
    Object? match = freezed,
    Object? matchPlayers = freezed,
    Object? hide = freezed,
  }) {
    return _then(_value.copyWith(
      match: match == freezed
          ? _value.match
          : match // ignore: cast_nullable_to_non_nullable
              as Match,
      matchPlayers: matchPlayers == freezed
          ? _value.matchPlayers
          : matchPlayers // ignore: cast_nullable_to_non_nullable
              as List<MatchPlayer>,
      hide: hide == freezed
          ? _value.hide
          : hide // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_CombinedMatchCopyWith<$Res>
    implements $CombinedMatchCopyWith<$Res> {
  factory _$$_CombinedMatchCopyWith(
          _$_CombinedMatch value, $Res Function(_$_CombinedMatch) then) =
      __$$_CombinedMatchCopyWithImpl<$Res>;
  @override
  $Res call({Match match, List<MatchPlayer> matchPlayers, bool hide});
}

/// @nodoc
class __$$_CombinedMatchCopyWithImpl<$Res>
    extends _$CombinedMatchCopyWithImpl<$Res>
    implements _$$_CombinedMatchCopyWith<$Res> {
  __$$_CombinedMatchCopyWithImpl(
      _$_CombinedMatch _value, $Res Function(_$_CombinedMatch) _then)
      : super(_value, (v) => _then(v as _$_CombinedMatch));

  @override
  _$_CombinedMatch get _value => super._value as _$_CombinedMatch;

  @override
  $Res call({
    Object? match = freezed,
    Object? matchPlayers = freezed,
    Object? hide = freezed,
  }) {
    return _then(_$_CombinedMatch(
      match: match == freezed
          ? _value.match
          : match // ignore: cast_nullable_to_non_nullable
              as Match,
      matchPlayers: matchPlayers == freezed
          ? _value._matchPlayers
          : matchPlayers // ignore: cast_nullable_to_non_nullable
              as List<MatchPlayer>,
      hide: hide == freezed
          ? _value.hide
          : hide // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_CombinedMatch implements _CombinedMatch {
  _$_CombinedMatch(
      {required this.match,
      required final List<MatchPlayer> matchPlayers,
      this.hide = false})
      : _matchPlayers = matchPlayers;

  @override
  final Match match;
  final List<MatchPlayer> _matchPlayers;
  @override
  List<MatchPlayer> get matchPlayers {
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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CombinedMatch &&
            const DeepCollectionEquality().equals(other.match, match) &&
            const DeepCollectionEquality()
                .equals(other._matchPlayers, _matchPlayers) &&
            const DeepCollectionEquality().equals(other.hide, hide));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(match),
      const DeepCollectionEquality().hash(_matchPlayers),
      const DeepCollectionEquality().hash(hide));

  @JsonKey(ignore: true)
  @override
  _$$_CombinedMatchCopyWith<_$_CombinedMatch> get copyWith =>
      __$$_CombinedMatchCopyWithImpl<_$_CombinedMatch>(this, _$identity);
}

abstract class _CombinedMatch implements CombinedMatch {
  factory _CombinedMatch(
      {required final Match match,
      required final List<MatchPlayer> matchPlayers,
      final bool hide}) = _$_CombinedMatch;

  @override
  Match get match => throw _privateConstructorUsedError;
  @override
  List<MatchPlayer> get matchPlayers => throw _privateConstructorUsedError;
  @override
  bool get hide => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_CombinedMatchCopyWith<_$_CombinedMatch> get copyWith =>
      throw _privateConstructorUsedError;
}
