import 'package:dartz/dartz.dart';
import 'package:taswaq_app/core/error/failures.dart';
import 'package:taswaq_app/features/cart_screen/data/models/FetchCartModel.dart';

import '../models/DeleteUserCartModel.dart';


abstract class CartScreenRemoteDs{
Future<Either<Failures,FetchCartModel>>fetchCart(String token);
Future<Either<Failures,FetchCartModel>>updateCartQuantity(String token,int count,String productId);
Future<Either<Failures,DeleteUserCartModel>>clearUserCart(String token );

}