import 'package:dartz/dartz.dart';
import 'package:taswaq_app/features/tabs/home_tab/data/models/AddProductToWhishlistModel.dart';
import 'package:taswaq_app/features/tabs/home_tab/data/models/GetWhishlistModel.dart';
import '../../../../../core/error/failures.dart';
import '../../../products_tab/data/models/ProductListModel.dart';
import '../../data/models/AddToCartModel.dart';
import '../../data/models/CategoriesModel.dart';

abstract class HomeTabRepo {
  Future<Either<Failures,ProductListModel>> fetchProducts();
  Future<Either<Failures,CategoriesModel>> fetchCategories();
  Future<Either<Failures,GetWhishlistModel>> getWhishlist();
  Future<Either<Failures,AddProductToWhishlistModel>> AddProductToWhishlist(String productId );
  Future<Either<Failures,AddProductToWhishlistModel>>RemoveProductFromWhishlist(String productId) ;
  Future<Either<Failures,AddToCartModel>>AddToCart(String productId);
}