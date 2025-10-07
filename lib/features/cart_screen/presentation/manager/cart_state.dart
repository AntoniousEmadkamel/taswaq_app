import 'package:taswaq_app/features/cart_screen/data/models/DeleteUserCartModel.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/FetchCartModel.dart';

enum CartStates { init, loading, success, error }

class CartState {
  final CartStates? cartStates;
  final FetchCartModel? cartModel;
  final DeleteUserCartModel?deleteUserCartModel;
  final Failures? productFailure;
  bool? isFav;
  List<String>? iDs;

  CartState({
    this.cartStates,
    this.cartModel,
    this.deleteUserCartModel,
    this.isFav,
    this.iDs,
    this.productFailure,
  });

  CartState copyWith({
    CartStates? cartStates,
    FetchCartModel?cartModel,
    DeleteUserCartModel?deleteUserCartModel,
    Failures? productFailure,
    bool? isFav,
    List<String>? iDs,
  }) {
    return CartState(
      cartStates: cartStates??this.cartStates,
      cartModel: cartModel??this.cartModel,
      deleteUserCartModel: deleteUserCartModel??this.deleteUserCartModel,
      productFailure: productFailure ?? this.productFailure,
      isFav: isFav,
      iDs: iDs ?? this.iDs,
    );
  }
}

class HomeInitial extends CartState {
  HomeInitial() : super(cartStates: CartStates.init);
}
