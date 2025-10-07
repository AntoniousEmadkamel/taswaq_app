import 'package:flutter/material.dart';
import 'package:taswaq_app/features/cart_screen/presentation/pages/cart_screen.dart';
import 'package:taswaq_app/features/forget_password/presentation/pages/forget_password_screen.dart';
import 'package:taswaq_app/features/login/presentation/pages/login_screen.dart';
import 'package:taswaq_app/features/onboarding/onboarding_page.dart';
import 'package:taswaq_app/features/otp_screen/presentation/pages/otp_screen.dart';
import 'package:taswaq_app/features/payment/presentation/pages/visa.dart';
import 'package:taswaq_app/features/reset_password_screen/presentation/pages/reset_password_screen.dart';
import 'package:taswaq_app/features/signup/presentation/pages/signup_screen.dart';
import 'package:taswaq_app/features/product_details_screen/presentation/pages/product_details_screen.dart';
import '../../features/signup/data/models/user_model.dart';
import '../../features/tabs/home_layout.dart';
import '../../features/tabs/products_tab/data/models/ProductListModel.dart';

class AppRoutes{
  static const String signup="signup";
  static const String login="login";
  static const String home="home";
  static const String cart="cart";
  static const String product="product";
  static const String visa="visa";
  static const String forgetPassword="forgetPassword";
  static const String otp="otp";
  static const String resetPassword="resetPassword";
  static const String onboarding="/";
}

class AppRouter {
  static Route onGenerateRoute(RouteSettings routeSettings){
    if(routeSettings.name==AppRoutes.signup){
      return MaterialPageRoute(builder: (context) => SignupScreen());
    }
    else if(routeSettings.name==AppRoutes.login){
      return MaterialPageRoute(builder: (context) => LoginScreen());
    }
    else if(routeSettings.name==AppRoutes.home){
      final args = routeSettings.arguments as UserModel?;
      return MaterialPageRoute(builder: (context) => HomeLayout(userData: args));
    }
    else if(routeSettings.name==AppRoutes.cart){
      return MaterialPageRoute(builder: (context) => CartScreen());
    }
    else if(routeSettings.name==AppRoutes.visa){
      return MaterialPageRoute(builder: (context) => VisaScreen());
    }
    else if(routeSettings.name==AppRoutes.product){
      final args = routeSettings.arguments as Data?;
      return MaterialPageRoute(builder: (context) => ProductDetailsScreen(productData: args));
    }
    else if(routeSettings.name==AppRoutes.forgetPassword){
      return MaterialPageRoute(builder: (context) => ForgetPasswordScreen());
    }
    else if(routeSettings.name==AppRoutes.otp){
      return MaterialPageRoute(builder: (context) => OtpScreen());
    }
    else if(routeSettings.name==AppRoutes.resetPassword){
      return MaterialPageRoute(builder: (context) => ResetPasswordScreen());
    }
    else if(routeSettings.name==AppRoutes.onboarding){
      return MaterialPageRoute(builder: (context) => OnboardingPage());
    }

    else{
      return MaterialPageRoute(builder:(context) {
        return Scaffold(
          appBar: AppBar(title: Text("Error"),),
          body: Center(child: Text("undefinedRoute")),
        );
      },);
    }
  }
}