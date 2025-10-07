import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taswaq_app/config/routes/app_route.dart';
import '../../../../core/components/network_image.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_defaults.dart';
import '../../../../core/utils/app_images.dart';
import '../../../forget_password/presentation/manager/forgot_password_screen_bloc.dart';
import '../widgets/verified_dialog.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => ForgotPasswordScreenBloc(),
  child: BlocConsumer<ForgotPasswordScreenBloc, ForgotPasswordScreenState>(
  listener: (context, state) {
    if (state.screenStatus == ScreenStatus.loading) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Center(
              child: CircularProgressIndicator(
                  backgroundColor: Colors.blueGrey)),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      );
    }
    else if (state.screenStatus == ScreenStatus.successfully) {
      Navigator.pop(context);
      showDialog(barrierDismissible: false, context: context, builder: (context) {
            return Dialog(
              backgroundColor: AppColors.blueColor,
              shape: RoundedRectangleBorder(borderRadius: AppDefaults.borderRadius),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppDefaults.padding * 3,
                  horizontal: AppDefaults.padding,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: NetworkImageWithLoader(
                          AppImages.verified,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppDefaults.padding),
                    Text(
                      'Congratulations!',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold,color: Colors.white),
                    ),
                    const SizedBox(height: AppDefaults.padding),
                    const Text(
                      'now, You can \nreset your password.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: AppDefaults.padding),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () =>
                            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.resetPassword,(route)=>false),
                        child:  Text('Reset password',style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w300,
                          fontSize: 18,
                          color: AppColors.blueColor,
                        ),),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    }
    else if (state.screenStatus == ScreenStatus.failure) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Error", style: TextStyle(fontSize: 18)),
          elevation: 0,
          content: SizedBox(
            height: 130,
            child: Column(
              children: [
                Text(state.failures?.message ?? "unknown error occurred",
                    maxLines: 3,
                    style: const TextStyle(color: Colors.red)),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("OK"))
              ],
            ),
          ),
        ),
      );
    }  },
  builder: (context, state) {
    return Scaffold(
      backgroundColor: AppColors.blueColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: const Column(
              children: [
                NumberVerificationHeader(),
                OTPTextFields(),
                SizedBox(height: AppDefaults.padding * 5),
                ConfirmOTPButton(),
                SizedBox(height: AppDefaults.padding),
                ResendButton(),

                SizedBox(height: AppDefaults.padding),
              ],
            ),
          ),
        ),
      ),
    );
  },
),
);
  }
}

class ConfirmOTPButton extends StatelessWidget {
  const ConfirmOTPButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          final bloc = ForgotPasswordScreenBloc.get(context);
          // Combine all 6 fields into one OTP code
          final otpCode = bloc.otpField1.text + bloc.otpField2.text + bloc.otpField3.text + bloc.otpField4.text + bloc.otpField5.text + bloc.otpField6.text;
          // Set the combined value to the original codeController
          bloc.codeController.text = otpCode;
          // Trigger the event
          bloc.add(ResetCodeClicked());
        },
        child: Text('Confirm OTP',style: GoogleFonts.poppins(
          fontWeight: FontWeight.w300,
          fontSize: 18,
          color: AppColors.blueColor,
        ),),
      ),
    );
  }
}

class ResendButton extends StatelessWidget {
  const ResendButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Did you don\'t get code?',style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize:16 ,color: Colors.white),
        ),
        TextButton(
          onPressed: () {

          },
          child:  Text('Resend', style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize:16 ,color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class NumberVerificationHeader extends StatelessWidget {
  const NumberVerificationHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppDefaults.padding),
        Text(
          'Entry Your 6 digit code',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white),
        ),
        const SizedBox(height: AppDefaults.padding),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child:  AspectRatio(
            aspectRatio: 1 / 1,
            child: NetworkImageWithLoader(
              AppImages.numberVerfication,
            ),
          ),
        ),
        const SizedBox(height: AppDefaults.padding * 3),
      ],
    );
  }
}

class OTPTextFields extends StatelessWidget {
  const OTPTextFields({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = ForgotPasswordScreenBloc.get(context);

    return Theme(
      data: ThemeData(inputDecorationTheme: InputDecorationTheme(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.1,color: Colors.white),
          borderRadius: BorderRadius.circular(25),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.1,color: Colors.white),
          borderRadius: BorderRadius.circular(25),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.1,color: Colors.white),
          borderRadius: BorderRadius.circular(25),
        ),
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: TextFormField(
              controller: bloc.otpField1,
              onChanged: (v) {if (v.length == 1) {FocusScope.of(context).nextFocus();} else {FocusScope.of(context).previousFocus();}},
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold,),
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,
            ),
          ),
          SizedBox(
            width: 60,
            height: 60,
            child: TextFormField(
              controller: bloc.otpField2,
              onChanged: (v) {if (v.length == 1) {FocusScope.of(context).nextFocus();} else {FocusScope.of(context).previousFocus();}},
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold,),
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,
            ),
          ),
          SizedBox(
            width: 60,
            height: 60,
            child: TextFormField(
              controller: bloc.otpField3,
              onChanged: (v) {if (v.length == 1) {FocusScope.of(context).nextFocus();} else {FocusScope.of(context).previousFocus();}},
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold,),
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,
            ),
          ),
          SizedBox(
            width: 60,
            height: 60,
            child: TextFormField(
              controller: bloc.otpField4,
              onChanged: (v) {if (v.length == 1) {FocusScope.of(context).nextFocus();} else {FocusScope.of(context).previousFocus();}},
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold,),
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,
            ),
          ),
          SizedBox(
            width: 60,
            height: 60,
            child: TextFormField(
              controller: bloc.otpField5,
              onChanged: (v) {
                if (v.length == 1) {FocusScope.of(context).nextFocus();} else {FocusScope.of(context).previousFocus();}},
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold,),
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,
            ),
          ),
          SizedBox(
            width: 60,
            height: 60,
            child: TextFormField(
              controller: bloc.otpField6,
              onChanged: (v) {if (v.length == 1) {FocusScope.of(context).nextFocus();} else {FocusScope.of(context).previousFocus();}},
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold,),
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
    );
  }
}