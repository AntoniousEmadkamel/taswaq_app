import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taswaq_app/features/login/presentation/bloc/login_bloc.dart';
import '../../../../config/routes/app_route.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../forget_password/presentation/manager/forgot_password_screen_bloc.dart';
import '../../../signup/presentation/widgets/custom_password_form_field.dart';
import '../../../signup/presentation/widgets/custom_text_form_widget.dart';
import '../../../signup/presentation/widgets/custom_text_widget_for_signUp.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool isPasswordVisible = false;
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
                          const Text(
                              "You have changed your password successfully"),
                          SizedBox(height: 30),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, AppRoutes.login, (route) => false);
                              },
                              child: const Text("Go to login page")),
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
                  height: 140,
                  child: Column(
                    children: [
                      Text(state.failures?.message ?? "unknown error occurred",
                          maxLines: 2,
                          style: const TextStyle(color: Colors.red)),
                      SizedBox(height: 30),
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
                        "Welcome Back To Route",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Reset your password",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 40),
                      CustomTextWidgetForSignup(text: "E-mail address"),
                      SizedBox(height: 24),
                      CustomTextFormField(
                        hintText: "enter your email address",
                        controller: bloc.emailController,
                      ),
                      SizedBox(height: 32),
                      CustomTextWidgetForSignup(text: "Password"),
                      SizedBox(height: 24),
                      CustomPasswordFormField(
                        controller: bloc.passwordController,
                        hintText: "enter your new password",
                        icon: true,
                        isVisible: isPasswordVisible,
                        onTap: () {
                          isPasswordVisible =
                              !isPasswordVisible; // Toggle visibility
                          setState(() {});
                        },
                      ),
                      SizedBox(height: 52),
                      ElevatedButton(
                        onPressed: () {
                          // bloc.add(LoginButtonClickedEvent());
                          if (formKey.currentState!.validate()) {
                            ForgotPasswordScreenBloc.get(context)
                                .add(ResetPasswordClicked());
                          }
                        },
                        child: Text(
                          "Confirm",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: AppColors.blueColor,
                          ),
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