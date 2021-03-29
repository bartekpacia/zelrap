import 'package:freezed_annotation/freezed_annotation.dart';

part 'celebrity.freezed.dart';

/// Represents a user who can stream.
@freezed
class Celebrity with _$Celebrity {
  factory Celebrity({
    required String name,
    required String photoUrl,
    required DateTime joinedDate,
    required bool isLive,
  }) = _Celebrity;
}
