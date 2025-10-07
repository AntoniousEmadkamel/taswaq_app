import 'package:dartz/dartz.dart';
import 'package:taswaq_app/features/cart_screen/data/models/FetchCartModel.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/DeleteUserCartModel.dart';
abstract class CartScreenRepo {
  Future<Either<Failures,FetchCartModel>>fetchCart();
  Future<Either<Failures,FetchCartModel>>updateCartQuantity(int count,String productId);
  Future<Either<Failures,DeleteUserCartModel>>clearUserCart();
}