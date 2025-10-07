import 'package:dartz/dartz.dart';
import 'package:taswaq_app/core/error/failures.dart';
import 'package:taswaq_app/features/tabs/home_tab/data/data_sources/home_tab_remote_ds.dart';
import 'package:taswaq_app/features/tabs/home_tab/data/models/AddProductToWhishlistModel.dart';
import 'package:taswaq_app/features/tabs/home_tab/data/models/CategoriesModel.dart';
import 'package:taswaq_app/features/tabs/home_tab/data/models/GetWhishlistModel.dart';
import 'package:taswaq_app/features/tabs/products_tab/data/models/ProductListModel.dart';
import '../../../../../core/cashe/shared_preferences.dart';
import '../../domain/repositories/home_tab_repo.dart';
import '../models/AddToCartModel.dart';

class HomeTabRepoImp implements HomeTabRepo {
 final HomeTabRemoteDs homeTabRemoteDs;

 HomeTabRepoImp(this.homeTabRemoteDs);

 Future<String?> _getToken() async {
  return await CacheData.getData("token");
 }

 @override
 Future<Either<Failures, ProductListModel>> fetchProducts() => homeTabRemoteDs.fetchProducts();
 Future<Either<Failures, CategoriesModel>> fetchCategories() => homeTabRemoteDs.fetchCategories();
 Future<Either<Failures, GetWhishlistModel>> getWhishlist() async {
  final token = await _getToken();
  return homeTabRemoteDs.getWhishlist(token ?? "");
 }
 Future<Either<Failures, AddProductToWhishlistModel>> AddProductToWhishlist(String productId) async {
  final token = await _getToken();
  return homeTabRemoteDs.AddProductToWhishList(token ?? "", productId);
 }
 Future<Either<Failures, AddProductToWhishlistModel>> RemoveProductFromWhishlist(String productId) async {
  final token = await _getToken();
  return homeTabRemoteDs.RemoveProductFromWhishlist(token ?? "", productId);
 }

  @override
  Future<Either<Failures, AddToCartModel>> AddToCart(String productId) async{
   final token = await _getToken();
   return homeTabRemoteDs.AddToCart(token??"", productId);
 }

}