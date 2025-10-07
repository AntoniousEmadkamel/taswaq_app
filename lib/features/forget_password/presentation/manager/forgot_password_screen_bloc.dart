import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../../core/api/api_manager.dart';
import '../../../../core/error/failures.dart';
import '../../../otp_screen/data/data_sources/remote_ds.dart';
import '../../../otp_screen/data/data_sources/remote_ds_impl.dart';
import '../../../otp_screen/data/repositories/reset_code_repo_impl.dart';
import '../../../otp_screen/domain/repositories/forgot_repo.dart';
import '../../../otp_screen/domain/use_cases/reset_code_usecase.dart';
import '../../../reset_password_screen/data/data_sources/remote_ds.dart';
import '../../../reset_password_screen/data/data_sources/remote_ds_impl.dart';
import '../../../reset_password_screen/data/repositories/reset_password_repo_impl.dart';
import '../../../reset_password_screen/domain/repositories/reset_password_repo.dart';
import '../../../reset_password_screen/domain/use_cases/reset_password_usecase.dart';
import '../../data/data_sources/remote_ds.dart';
import '../../data/data_sources/remote_ds_impl.dart';
import '../../data/models/MessageModel.dart';
import '../../data/repositories/forgot_repo_impl.dart';
import '../../domain/repositories/forgot_repo.dart';
import '../../domain/use_cases/forgot_password_usecase.dart';
part 'forgot_password_screen_event.dart';
part 'forgot_password_screen_state.dart';

class ForgotPasswordScreenBloc
    extends Bloc<ForgotPasswordScreenEvent, ForgotPasswordScreenState> {
  static ForgotPasswordScreenBloc get(context) => BlocProvider.of(context);
  TextEditingController emailController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController otpField1 = TextEditingController();
  TextEditingController otpField2 = TextEditingController();
  TextEditingController otpField3 = TextEditingController();
  TextEditingController otpField4 = TextEditingController();
  TextEditingController otpField5 = TextEditingController();
  TextEditingController otpField6 = TextEditingController();

  ForgotPasswordScreenBloc() : super(ForgotPasswordScreenInitial()) {
    on<ForgotPasswordScreenEvent>((event, emit) async {
      if (event is ForgotPasswordClicked) {
        emit(state.copyWith(screenStatus: ScreenStatus.loading));
        ApiManager apiManager = ApiManager();
        PasswordRemoteDS passwordRemoteDS = PasswordRemoteDSImpl(apiManager);
        ForgotPasswordRepo forgotPasswordRepo =
            ForgotRepoImpl(passwordRemoteDS);
        ForgotPasswordUseCase passwordUseCase =
            ForgotPasswordUseCase(forgotPasswordRepo);
        var result = await passwordUseCase.call(emailController.text);
        result.fold((l) {
          emit(
              state.copyWith(screenStatus: ScreenStatus.failure, failures: l));
        }, (r) {
          emit(state.copyWith(
              screenStatus: ScreenStatus.successfully, messageModel: r));
        });
      }
      else if (event is ResetCodeClicked) {
        emit(state.copyWith(screenStatus: ScreenStatus.loading));
        ApiManager apiManager = ApiManager();
        ResetCodeDS resetCodeDS = ResetCodeDsImpl(apiManager);
        ResetCodeRepo resetCodeRepo = ResetCodeRepoImpl(resetCodeDS);
        ResetCodeUseCase resetCodeUseCase = ResetCodeUseCase(resetCodeRepo);
        var result = await resetCodeUseCase.call(codeController.text);
        result.fold((l) {
          emit(
              state.copyWith(screenStatus: ScreenStatus.failure, failures: l));
        }, (r) {
          emit(state.copyWith(
              screenStatus: ScreenStatus.successfully, messageModel: r));
        });
      }
      else if (event is ResetPasswordClicked) {
        emit(state.copyWith(screenStatus: ScreenStatus.loading));
        ApiManager apiManager = ApiManager();
        ResetPasswordDs resetPasswordDs = ResetPasswordDsImpl(apiManager);
        ResetPasswordRepo resetPasswordRepo = ResetPasswordRepoImpl(resetPasswordDs);
        ResetPasswordUseCase resetPasswordUseCase = ResetPasswordUseCase(resetPasswordRepo);
        var result = await resetPasswordUseCase.call(
            emailController.text, passwordController.text);
        result.fold((l) {
          print("9898989898998    $l   989898989");
          emit(
              state.copyWith(screenStatus: ScreenStatus.failure, failures: l));
        }, (r) {
          emit(state.copyWith(
              screenStatus: ScreenStatus.successfully, messageModel: r));
        });
      }
    });
  }
}
