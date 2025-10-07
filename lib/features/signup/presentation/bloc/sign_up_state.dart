part of 'sign_up_bloc.dart';
enum RegisterStates{init, loading ,success, error}

@immutable
class SignUpState {
  final RegisterStates? registerState;
  final Failures? failures;
  final UserEntity? userData;
  SignUpState({this.registerState, this.failures, this.userData});

  SignUpState copyWith(
    {
    RegisterStates? state,
    Failures? failures,
    UserEntity? userData
    }
      ){
    return SignUpState(
        registerState:state??this.registerState ,
        userData: userData??this.userData,
        failures: failures??this.failures
    );
  }

}

class SignUpInitial extends SignUpState {

  SignUpInitial():super(registerState: RegisterStates.init);
}
