class EndPoints {
  static const String signUp = "/api/v1/auth/signup";
  static const String signIn = "/api/v1/auth/signin";
  static const String productList = "/api/v1/products";
  static const String forgotPassword = "/api/v1/auth/forgotPasswords";
  static const String resetCode = "/api/v1/auth/verifyResetCode";
  static const String resetPassword = "/api/v1/auth/resetPassword";
  static const String getCategories = "/api/v1/categories";
  static const String getBrands = "/api/v1/brands";
  static const String addToCart = "/api/v1/cart";
  static const String getCart = "/api/v1/cart";
  static const String updateProductQuantityToCart = "/api/v1/cart";
  static const String clearUserCart = "/api/v1/cart";

  static const String addToWishList = "/api/v1/wishlist";
  static const String getWishList = "/api/v1/wishlist";
  static const String deleteFromWishList = "/api/v1/wishlist/";
  static const String changePassword = "/api/v1/users/changeMyPassword";
}
