import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:taswaq_app/core/api/api_manager.dart';
import 'package:taswaq_app/core/error/failures.dart';
import 'package:taswaq_app/features/signup/data/data_sources/remote/remote_ds_impl.dart';
import 'package:taswaq_app/features/signup/data/data_sources/remote/renote_ds.dart';
import 'package:taswaq_app/features/signup/data/repositories/signup_repo_impl.dart';
import 'package:taswaq_app/features/signup/domain/entities/UserEntity.dart';
import 'package:taswaq_app/features/signup/domain/repositories/signup_repo.dart';
import 'package:taswaq_app/features/signup/domain/use_cases/signup_usecase.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
   bool isPasswordVisible = false; // Add this state variable

  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController rePasswordController=TextEditingController();
  TextEditingController phoneController=TextEditingController();

  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpEvent>((event, emit) async{
      if(event is SignUpButtonClickedEvent) {
        emit (state.copyWith(state: RegisterStates.loading));
        ApiManager apiManager =ApiManager();
        SignUpRemoteDs signUpRemoteDs=SignUpRemoteDsImpl(apiManager);
        SignupRepo signupRepo=SignupRepoImpl(signUpRemoteDs);
        SignupUseCase signupUseCase=SignupUseCase(signupRepo);

          var result=await signupUseCase.call(nameController.text, emailController.text, passwordController.text, passwordController.text, phoneController.text);
          result.fold((l) {
            emit(state.copyWith(state: RegisterStates.error,failures: l));
          }, (r) {
            emit(state.copyWith(state: RegisterStates.success,userData: r));
          },);

      }

    });
  }
}
