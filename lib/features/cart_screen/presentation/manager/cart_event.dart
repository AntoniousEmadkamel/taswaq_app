part of 'cart_bloc.dart';

abstract class CartEvent {}
class FetchCartEvent extends CartEvent {}
class UpdateCartQuantityEvent extends CartEvent {
  int? count;
  String? productId;
  UpdateCartQuantityEvent({required this.count,required this.productId});
}
class ClearUserCartEvent extends CartEvent {}
