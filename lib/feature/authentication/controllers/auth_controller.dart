import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:networking_practice/database/local/shared_preferences/shared_preferences_config.dart';
import 'package:networking_practice/feature/authentication/repository/auth_repository.dart';

import '../../../config/di/dependency_injection.dart';
import 'auth_generic.dart';

final authProvider = StateNotifierProvider<AuthController, AuthGeneric>(
    (ref) => AuthController(ref: ref));

class AuthController extends StateNotifier<AuthGeneric> {
  final prefs = sl.get<SharedPreferencesConfig>();

  AuthController({required this.ref}) : super(AuthGeneric());
  Ref ref;
  AuthRepository authRepository = AuthRepository();

  Future<bool> signup(String emailAddress, String password) async {
    print(emailAddress + password);
    state = state.update(isLoading: true);
    bool result = await authRepository.signup(emailAddress, password);
    state = state.update(isLoading: false, isSuccess: result);
    return result;
  }

  Future<bool> login(String emailAddress, String password) async {
    state = state.update(isLoading: true);
    bool result = await authRepository.login(emailAddress, password);
    state = state.update(isLoading: false, isSuccess: result);
    await prefs.saveLoginState(true);
    return result;
  }

  Future<bool> logout() async {
    state = state.update(isLoading: true);
    bool result = await authRepository.logout();
    state = state.update(isLoading: false, isSuccess: result);
    await prefs.saveLoginState(false);
    return result;
  }
}
