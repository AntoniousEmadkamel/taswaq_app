import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taswaq_app/features/login/presentation/bloc/login_bloc.dart';
import '../../../../config/routes/app_route.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../signup/presentation/widgets/custom_password_form_field.dart';
import '../../../signup/presentation/widgets/custom_text_form_widget.dart';
import '../../../signup/presentation/widgets/custom_text_widget_for_signUp.dart';
import '../manager/forgot_password_screen_bloc.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  var formKey = GlobalKey<FormState>();

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
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("success",
                        style: TextStyle(color: Colors.green, fontSize: 18)),
                    elevation: 0,
                    content: SizedBox(
                      height: 140,
                      child: Column(
                        children: [
                          Text(
                              "${state.messageModel?.message}"),
                          Spacer(),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pushNamedAndRemoveUntil(
                                    context, AppRoutes.otp,(route)=>false);
                              },
                              child: const Text("OK")),
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
                  height: 150,
                  child: Column(
                    children: [
                      Text(state.failures?.message ?? "unknown error occurred",
                          style: const TextStyle(color: Colors.red)),
                      Spacer(),
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
          }
        },
        builder: (context, state) {
          var bloc = BlocProvider.of<ForgotPasswordScreenBloc>(context);
          return Scaffold(
            appBar: AppBar(elevation: 0, backgroundColor: AppColors.blueColor),
            backgroundColor: AppColors.blueColor,
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(
                        "assets/images/route.png",
                        width: 237,
                        height: 71,
                      ),
                      SizedBox(height: 86.9),
                      Text(
                        "Forget Password",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Please enter your registered e-mail to get the otp",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 80),
                      CustomTextWidgetForSignup(text: "E-mail address"),
                      SizedBox(height: 24),
                      CustomTextFormField(
                        hintText: "enter your email address",
                        controller: bloc.emailController,
                      ),
                      SizedBox(height: 100),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            ForgotPasswordScreenBloc.get(context).add(ForgotPasswordClicked());
                          }
                        },
                        child: Text(
                          "Send OTP",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: AppColors.blueColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      RichText(textAlign: TextAlign.center,text: TextSpan(
                        text: 'Didn’t receive the OTP ? ',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize:18 ,color: Colors.white),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Send again',
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize:16 ,color: Colors.white),
                          ),
                        ],
                      ),
                      ),
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