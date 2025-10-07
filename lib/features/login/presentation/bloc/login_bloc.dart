import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:taswaq_app/core/api/api_manager.dart';
import 'package:taswaq_app/core/error/failures.dart';
import 'package:taswaq_app/features/login/data/data_sources/local/login_local_ds.dart';
import 'package:taswaq_app/features/login/data/data_sources/local/login_local_ds_impl.dart';
import 'package:taswaq_app/features/login/data/data_sources/remote/remote_ds.dart';
import 'package:taswaq_app/features/login/data/data_sources/remote/remote_ds_impl.dart';
import 'package:taswaq_app/features/login/data/repositories/login_repo_impl.dart';
import 'package:taswaq_app/features/login/domain/repositories/login_repo.dart';
import 'package:taswaq_app/features/login/domain/use_cases/login_usecase.dart';
import 'package:taswaq_app/features/signup/data/models/user_model.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  TextEditingController nameController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async{
    if(event is LoginButtonClickedEvent){
      emit(state.copyWith(screenState: LoginStates.loading));
      ApiManager apiManager=ApiManager();
      LoginRemoteDs loginRemoteDs =LoginRemoteDsImpl(apiManager);
      LogInLocalDS logInLocalDS=LoginLocalDsImpl();
      LoginRepo loginRepo=LoginRepoImpl(loginRemoteDs,logInLocalDS);
      LoginUseCase loginUseCase=LoginUseCase(loginRepo);
      var result=await loginUseCase.call(nameController.text, passwordController.text);
      result.fold((l) {
        emit(state.copyWith(screenState: LoginStates.error ,loginFailure:l));
      },(r) {
        emit (state.copyWith(screenState: LoginStates.success , loginData: r));
      },);
    }
    });
  }
}