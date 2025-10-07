part of 'home_bloc.dart';

abstract class HomeEvent {}

class FetchProductListEvent extends HomeEvent{}

class FetchCategoriesEvent extends HomeEvent{}

class FetchWhishlistEvent extends HomeEvent{
  // String token;
  // FetchWhishlistEvent({required this.token});
}

class AddProductToWhishlistEvent extends HomeEvent{
  String productId;
  // String token;
  // AddProductToWhishlistEvent({required this.token,required this.productId});
  AddProductToWhishlistEvent({required this.productId});

}

class RemoveProductFromWhishlistEvent extends HomeEvent{
  String productId;
  // String token;
  // RemoveProductFromWhishlistEvent({required this.token,required this.productId});
  RemoveProductFromWhishlistEvent({required this.productId});

}

class ChangeFavIcon extends HomeEvent {
  final bool isFave;
  ChangeFavIcon(this.isFave);
}

class AddToCartEvent extends HomeEvent {
  String productId;
  AddToCartEvent({required this.productId});
}