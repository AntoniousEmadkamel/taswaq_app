import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taswaq_app/config/routes/app_route.dart';
import 'package:taswaq_app/core/utils/app_colors.dart';
import '../../../../core/components/network_image.dart';
import '../../../../core/utils/app_defaults.dart';
import '../../../../core/utils/app_images.dart';

class VerifiedDialog extends StatelessWidget {
  const VerifiedDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              'Verified!',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold,color: Colors.white),
            ),
            const SizedBox(height: AppDefaults.padding),
            const Text(
              'Hurrah!!  You have successfully\nverified the account.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: AppDefaults.padding),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, AppRoutes.resetPassword),
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
  }
}
