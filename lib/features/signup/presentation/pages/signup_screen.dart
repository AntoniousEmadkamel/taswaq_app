import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taswaq_app/config/routes/app_route.dart';
import 'package:taswaq_app/core/utils/app_colors.dart';
import 'package:taswaq_app/features/signup/presentation/widgets/custom_password_form_field.dart';
import 'package:taswaq_app/features/signup/presentation/widgets/custom_text_form_widget.dart';
import 'package:taswaq_app/features/signup/presentation/widgets/custom_text_widget_for_signUp.dart';
import '../bloc/sign_up_bloc.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isPasswordVisible=false;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => SignUpBloc(),
      child: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state.registerState == RegisterStates.loading) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder:
                  (context) => const AlertDialog(
                    title: Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.grey,
                      ),
                    ),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
            );
          } else if (state.registerState == RegisterStates.success) {
            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login,(route)=>false);
          } else if (state.registerState == RegisterStates.error) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text("Error", style: TextStyle(fontSize: 18)),
                    elevation: 0,
                    content: SizedBox(
                      height: 450,
                      child: Column(
                        children: [
                          Text(
                            state.failures?.message ?? "unknown error occurred",
                            style: const TextStyle(color: Colors.red),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      ),
                    ),
                  ),
            );
          }
        },
        builder: (context, state) {
          var bloc = BlocProvider.of<SignUpBloc>(context);

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
                      SizedBox(height: 46.9),
                      CustomTextWidgetForSignup(text: "userName"),
                      SizedBox(height: 24),
                      CustomTextFormField(
                        hintText: "enter your name",
                        controller: bloc.nameController,
                      ),
                      SizedBox(height: 32),
                      CustomTextWidgetForSignup(text: "Mobile Number"),
                      SizedBox(height: 24),
                      CustomTextFormField(
                        hintText: "enter your mobile no.",
                        controller: bloc.phoneController,
                      ),
                      SizedBox(height: 32),
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
                        hintText: "enter your password",
                        icon: true,
                        isVisible: isPasswordVisible,
                        onTap: () {
                          isPasswordVisible = !isPasswordVisible; // Toggle visibility
                          setState(() {});
                        },
                      ),
                      SizedBox(height: 56),
                      ElevatedButton(
                        onPressed: () {
                          bloc.add(SignUpButtonClickedEvent());
                        },
                        child: Text(
                          "Sign UP",
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