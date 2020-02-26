import 'user.dart';
import 'package:cloudying/login_state.dart';
import 'package:cloudying/auth_state.dart';

class AppState {
  final AppUser appUser; // 用户的信息数据
  final LoginState loginState; // 登录页面


  AppState({this.appUser, this.loginState});

  factory AppState.initial() {
    return AppState(
      loginState: LoginState.initial(),

    );
  }

  AppState copyWith({
    final AppUser appUser,
    final LoginState loginState,

  }) {
    return AppState(
      appUser: appUser ?? this.appUser,
      loginState: loginState ?? this.loginState,

    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          appUser == other.appUser &&
          loginState == other.loginState ;


  @override
  int get hashCode =>
      appUser.hashCode ^ loginState.hashCode ;

  @override
  String toString() {
    return 'AppState{appUser: $appUser, loginState: $loginState}';
  }
}
