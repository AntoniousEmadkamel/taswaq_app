import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taswaq_app/features/login/presentation/bloc/login_bloc.dart';
import '../../../../config/routes/app_route.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../signup/presentation/widgets/custom_password_form_field.dart';
import '../../../signup/presentation/widgets/custom_text_form_widget.dart';
import '../../../signup/presentation/widgets/custom_text_widget_for_signUp.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordVisible = false;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.state == LoginStates.loading) {
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
          } else if (state.state == LoginStates.success) {
            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home,arguments: state.userDatat,(route)=>false);
          } else if (state.state == LoginStates.error) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder:
                  (context) => AlertDialog(
                    title: const Text("Error", style: TextStyle(fontSize: 18)),
                    elevation: 0,
                    content: SizedBox(
                      height: 450,
                      child: Column(
                        children: [
                          Text(
                            state.loginFailures?.message ??
                                "unknown error occurred",
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
          var bloc = BlocProvider.of<LoginBloc>(context);
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
                        "Please sign in with your mail",
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
                        controller: bloc.nameController,
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
                          isPasswordVisible =
                              !isPasswordVisible; // Toggle visibility
                          setState(() {});
                        },
                      ),
                      SizedBox(height: 16),
                      InkWell(onTap: () {
                        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.forgetPassword,(route)=>false);
                      },child: Text("Forget Password",style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize:18 ,color: Colors.white),textAlign: TextAlign.right,)),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          bloc.add(LoginButtonClickedEvent());
                        },
                        child: Text(
                          "Login",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: AppColors.blueColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      InkWell(
                        onTap: (){
                          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.signup,(route)=>false);
                        },
                        child: RichText(textAlign: TextAlign.center,text: TextSpan(
                          text: 'Don’t have an account? ',
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize:18 ,color: Colors.white),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Create Account',
                              style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize:16 ,color: Colors.white),
                            ),
                          ],
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