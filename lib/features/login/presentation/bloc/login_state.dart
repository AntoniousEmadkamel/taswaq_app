part of 'login_bloc.dart';

enum LoginStates{init, loading, success , error}

@immutable
 class LoginState {
 final LoginStates? state;
 final UserModel? userDatat;
 final Failures? loginFailures;

 LoginState({this.state, this.userDatat, this.loginFailures});

 LoginState copyWith(
     {LoginStates? screenState, Failures? loginFailure, UserModel? loginData} ){
   return LoginState(
    state: screenState??this.state,
    loginFailures: loginFailure ??this.loginFailures,
    userDatat: loginData??this.userDatat,
   );
 }
}

class LoginInitial extends LoginState {

  LoginInitial():super(state: LoginStates.init);
}
