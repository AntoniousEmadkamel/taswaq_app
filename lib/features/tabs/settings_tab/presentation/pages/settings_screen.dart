import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taswaq_app/features/signup/data/models/user_model.dart';
import 'package:taswaq_app/features/tabs/settings_tab/presentation/widgets/custom_password_form_field_for_settings.dart';
import 'package:taswaq_app/features/tabs/settings_tab/presentation/widgets/custom_text_widget_for_settings.dart';

import '../../../../../core/cashe/shared_preferences.dart';
class SettingsScreen extends StatefulWidget {
  final UserModel? userData;
  const SettingsScreen({required this.userData,super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? name="";
  String? email="";
  bool isPasswordVisible=false;

  @override
  void initState() {
    super.initState();
    fetchData();

  }
  Future<void> fetchData() async {
    name = await CacheData.getData("name");
    email = await CacheData.getData("email");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height:25 ,),
              Image.asset("assets/images/route_logo.png",width: 66,height: 22),
              SizedBox(height:10 ,),
              // Text("Welcome, ${widget.userData?.user?.name??""}",style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 18 ,color: Color(0xff06004F)),),
              Text("Welcome, ${name??""}",style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 18 ,color: Color(0xff06004F)),),

              // Text("${widget.userData?.user?.email??""}",style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 14 ,color: Color(0x9906004f)),),
              Text("${email??""}",style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 14 ,color: Color(0x9906004f)),),

              SizedBox(height: 40),
              CustomTextWidgetForSettings(text: "Your full name"),
              SizedBox(height: 16),
              CustomPasswordFormFieldForSettings(
                // hintText: widget.userData?.user?.name??"",
                hintText: name??"",
                icon: true,
                isVisible: isPasswordVisible,
              ),
              SizedBox(height: 24),
              CustomTextWidgetForSettings(text: "Your E-mail "),
              SizedBox(height: 16),
              CustomPasswordFormFieldForSettings(
                // hintText: "${widget.userData?.user?.email??""}",
                hintText: "${email??""}",
                icon: true,
                isVisible: isPasswordVisible,
              ),
            ]
        ),
      ),
    );
  }
}