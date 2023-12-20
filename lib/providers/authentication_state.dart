import 'package:freezed_annotation/freezed_annotation.dart';

part 'authentication_state.freezed.dart';

@freezed
class AuthenticationState with _$AuthenticationState {
  factory AuthenticationState({
    String? token,
    required bool isLoading,
  }) = _AuthenticationState;
}
