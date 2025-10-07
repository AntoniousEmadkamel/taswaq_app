import '../../../core/utils/app_images.dart';
import 'onboarding_model.dart';

class OnboardingData {
  static List<OnboardingModel> items = [
    OnboardingModel(
      imageUrl: AppImages.onboarding1,
      headline: 'Browse all the category',
      description:
          'In our e-commerce we can find multiple categories for shopping .',
    ),
    OnboardingModel(
      imageUrl: AppImages.onboarding2,
      headline: 'Amazing Discounts & Offers',
      description:
          'In our e-commerce you can find many offers suitable for your need  .',
    ),
    OnboardingModel(
      imageUrl: AppImages.onboarding3,
      headline: 'Delivery in 30 Min',
      description:
          'In our e-commerce you have feature to receive your order from home  .',
    ),
  ];
}
