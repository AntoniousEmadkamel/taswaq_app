import 'package:dartz/dartz.dart';
import 'package:taswaq_app/core/error/failures.dart';
import 'package:taswaq_app/features/tabs/home_tab/data/models/AddProductToWhishlistModel.dart';
import 'package:taswaq_app/features/tabs/home_tab/data/models/CategoriesModel.dart';
import 'package:taswaq_app/features/tabs/home_tab/data/models/GetWhishlistModel.dart';
import 'package:taswaq_app/features/tabs/products_tab/data/models/ProductListModel.dart';

import '../models/AddToCartModel.dart';

abstract class HomeTabRemoteDs{
Future<Either<Failures,ProductListModel>> fetchProducts();
Future<Either<Failures,CategoriesModel>> fetchCategories();
Future<Either<Failures,GetWhishlistModel>> getWhishlist(String token);
Future<Either<Failures,AddProductToWhishlistModel>> AddProductToWhishList(String token,String productId);
Future<Either<Failures,AddProductToWhishlistModel>>RemoveProductFromWhishlist(String token,String productId) ;
Future<Either<Failures,AddToCartModel>>AddToCart(String token,String productId);
}