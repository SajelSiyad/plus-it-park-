import 'package:plus_it_park_machine_test/providers/authentication_state.dart';
import 'package:plus_it_park_machine_test/services/api_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'authentication_provider.g.dart';

@Riverpod(keepAlive: true)
class Authentication extends _$Authentication {
  @override
  AuthenticationState build() {
    return AuthenticationState(
      token: null,
      isLoading: false,
    );
  }

  Future<String?> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true);
    try {
      final authModel = await ApiService()
          .registerUser(name: name, email: email, password: password);
      if (authModel == null) {
        return 'Invalid input. Please try again';
      }

      state = state.copyWith(token: authModel.token, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      return 'Cannot signup. Please try again';
    }

    return null;
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true);
    try {
      final authModel =
          await ApiService().loginUser(email: email, password: password);
      if (authModel == null) {
        return 'Invalid input. Please try again';
      }

      state = state.copyWith(token: authModel.token, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      return 'Cannot login. Please try again';
    }

    return null;
  }

  void logout() {
    state = state.copyWith(token: null);
  }

  Future<String?> deleteUser() async {
    state = state.copyWith(isLoading: true);
    try {
      final isDeleted = await ApiService().deleteUser(
        token: state.token!,
      );
      state = state.copyWith(isLoading: false);

      if (isDeleted) {
        state = state.copyWith(token: null, isLoading: false);
        return 'User deleted successfully';
      } else {
        return 'Invalid user. Cannot delete';
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
      return 'Cannot delete user. Please try again';
    }
  }

  Future<String> update({
    required String name,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true);
    try {
      final isUpdated = await ApiService().updateUser(
        password: password,
        name: name,
        token: state.token!,
      );
      state = state.copyWith(isLoading: false);

      if (isUpdated) {
        return 'User data updated';
      } else {
        return 'Invalid input. Try again';
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
      return 'Cannot update. Please try again';
    }
  }

  Future<String> protected() async {
    try {
      final message = await ApiService().protectedData(token: state.token!);
      return message ?? 'Not able to get protected message';
    } catch (e) {
      return 'Cannot get protected message';
    }
  }
}
