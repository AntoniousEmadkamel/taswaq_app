import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:taswaq_app/core/api/api_manager.dart';
import 'package:taswaq_app/core/api/end_points.dart';
import 'package:taswaq_app/core/error/failures.dart';
import 'package:taswaq_app/features/tabs/home_tab/data/data_sources/home_tab_remote_ds.dart';
import 'package:taswaq_app/features/tabs/home_tab/data/models/AddProductToWhishlistModel.dart';
import 'package:taswaq_app/features/tabs/home_tab/data/models/CategoriesModel.dart';
import 'package:taswaq_app/features/tabs/home_tab/data/models/GetWhishlistModel.dart';
import 'package:taswaq_app/features/tabs/products_tab/data/models/ProductListModel.dart';

import '../models/AddToCartModel.dart';

class HomeTabRemoteDsImpl implements HomeTabRemoteDs{
  ApiManager apiManager;
  HomeTabRemoteDsImpl(this.apiManager);

  @override
  Future<Either<Failures, ProductListModel>> fetchProducts() async{
    try {
      Response response=await apiManager.getData(endPoint: EndPoints.productList, data: {});
      var productsList =ProductListModel.fromJson(response.data);
     return right(productsList);
    }
    catch(e){
      return left(RemoteFailures(e.toString()));
    }

  }

  Future<Either<Failures, CategoriesModel>> fetchCategories() async{
    try {
      Response response=await apiManager.getData(endPoint: EndPoints.getCategories,data: {});
      var categoriesList=CategoriesModel.fromJson(response.data);
      return right(categoriesList);
    }
    catch(e){
      return left(RemoteFailures(e.toString()));
    }

  }

  @override
  Future<Either<Failures, GetWhishlistModel>> getWhishlist(String token) async{
    try {
      Response response=await apiManager.getData(endPoint: EndPoints.getWishList, data: {},token: token);
      var whishList=GetWhishlistModel.fromJson(response.data);
      return right(whishList);
    }
    catch(e){
      return left(RemoteFailures(e.toString()));
    }
  }

  @override
  Future<Either<Failures, AddProductToWhishlistModel>> AddProductToWhishList(String token, String productId) async{
    try {
      Response response=await apiManager.postData(endPoint: EndPoints.addToWishList, body: {"productId":productId},token: token);
      var AddProductTowhishList=AddProductToWhishlistModel.fromJson(response.data);
      return right(AddProductTowhishList);
    }
    catch(e){
      return left(RemoteFailures(e.toString()));
    }
  }

  @override
  Future<Either<Failures, AddProductToWhishlistModel>> RemoveProductFromWhishlist(String token, String productId)async{
    try {
      Response response=await apiManager.delData(endPoint: EndPoints.deleteFromWishList, body: {},token: token,productId: productId);
      var RemoveProductTowhishList=AddProductToWhishlistModel.fromJson(response.data);
      return right(RemoveProductTowhishList);
    }
    catch(e){
      return left(RemoteFailures(e.toString()));
    }
  }

  @override
  Future<Either<Failures, AddToCartModel>> AddToCart(String token, String productId) async{
    try {
      Response response = await apiManager.postData(endPoint: EndPoints.addToCart, body: {"productId": productId}, token: token);
      var addToCart=AddToCartModel.fromJson(response.data);
      return Right(addToCart);
    }
    catch(e){
      return Left(RemoteFailures(e.toString()));
    }
  }

}