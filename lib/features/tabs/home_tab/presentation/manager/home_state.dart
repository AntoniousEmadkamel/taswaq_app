part of 'home_bloc.dart';

enum HomeStates { init, loading, success, error }

class HomeState {
  final HomeStates? homeState;
  final ProductListModel? productListModel;
  final CategoriesModel? categoriesModel;
  final GetWhishlistModel? getWhishlistModel;
  final AddProductToWhishlistModel? addProductToWhishlistModel;
  final AddProductToWhishlistModel? removeProductFromWhishlistModel;
  final AddToCartModel? addToCartModel;
  final Failures? productFailure;
  bool? isFav;
  List<String>? iDs;

  HomeState({
    this.homeState,
    this.productListModel,
    this.categoriesModel,
    this.getWhishlistModel,
    this.addProductToWhishlistModel,
    this.removeProductFromWhishlistModel,
    this.addToCartModel,
    this.isFav,
    this.iDs,
    this.productFailure,
  });

  HomeState copyWith({
    HomeStates? homeState,
    ProductListModel? productListModel,
    CategoriesModel? categoriesModel,
    GetWhishlistModel? getWhishlistModel,
    AddProductToWhishlistModel? addProductToWhishlistModel,
    AddProductToWhishlistModel? removeProductFromWhishlistModel,
    AddToCartModel?addToCartModel,
    Failures? productFailure,
    bool? isFav,
    List<String>? iDs,
  }) {
    return HomeState(
      homeState: homeState ?? this.homeState,
      productListModel: productListModel ?? this.productListModel,
      categoriesModel: categoriesModel ?? this.categoriesModel,
      getWhishlistModel: getWhishlistModel ?? this.getWhishlistModel,
      addProductToWhishlistModel: addProductToWhishlistModel ?? this.addProductToWhishlistModel,
      removeProductFromWhishlistModel: removeProductFromWhishlistModel ?? this.removeProductFromWhishlistModel,
      addToCartModel: addToCartModel??this.addToCartModel,
      productFailure: productFailure ?? this.productFailure,
      isFav: isFav,
      iDs: iDs ?? this.iDs,
    );
  }
}

class HomeInitial extends HomeState {
  HomeInitial() : super(homeState: HomeStates.init);
}
