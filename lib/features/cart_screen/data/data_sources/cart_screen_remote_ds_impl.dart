import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:taswaq_app/core/api/api_manager.dart';
import 'package:taswaq_app/core/api/end_points.dart';
import 'package:taswaq_app/core/error/failures.dart';
import 'package:taswaq_app/features/cart_screen/data/data_sources/cart_screen_remote_ds.dart';
import 'package:taswaq_app/features/cart_screen/data/models/DeleteUserCartModel.dart';
import 'package:taswaq_app/features/cart_screen/data/models/FetchCartModel.dart';

import '../models/ErrorModel.dart';

class CartScreenRemoteDsImpl implements CartScreenRemoteDs{
  ApiManager apiManager;
  CartScreenRemoteDsImpl(this.apiManager);

  @override
  Future<Either<Failures, FetchCartModel>> fetchCart(String token) async{
    try {
      Response response = await apiManager.getData(endPoint: EndPoints.getCart, data: {}, token: token);
      var cart=FetchCartModel.fromJson(response.data);
      return Right(cart);
    }
    catch(e){
      return Left(RemoteFailures(e.toString()));
    }
  }

  @override
  Future<Either<Failures, FetchCartModel>> updateCartQuantity(String token,int count,String productId) async{
    try {

      Response response = await apiManager.putData(endPoint: "${EndPoints.updateProductQuantityToCart}/$productId", body: {"count": count}, token: token);
      var cart=FetchCartModel.fromJson(response.data);
      return Right(cart);
    }
    on DioException catch (e) {
      Map<String, dynamic> response = jsonDecode(e.response.toString());
      ErrorModel errorModel = ErrorModel.fromJson(response);
      print(errorModel.message ?? "");
      return Left(RemoteFailures(errorModel.message.toString()));
    }
  }

  @override
  Future<Either<Failures, DeleteUserCartModel>> clearUserCart(String token) async{
    try {
      Response response = await apiManager.del(endPoint: EndPoints.clearUserCart, body: {}, token: token);
      var message=DeleteUserCartModel.fromJson(response.data);
      return Right(message);
    }
    on DioException catch(e){
      Map<String, dynamic> response = jsonDecode(e.response.toString());
      ErrorModel errorModel = ErrorModel.fromJson(response);

      return Left(RemoteFailures(errorModel.message ?? ""));
    }
  }

}