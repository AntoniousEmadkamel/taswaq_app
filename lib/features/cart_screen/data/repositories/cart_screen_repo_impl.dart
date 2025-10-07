import 'package:dartz/dartz.dart';
import 'package:taswaq_app/features/cart_screen/data/data_sources/cart_screen_remote_ds.dart';
import 'package:taswaq_app/features/cart_screen/data/models/DeleteUserCartModel.dart';
import 'package:taswaq_app/features/cart_screen/domain/repositories/cart_screen_repo.dart';
import 'package:taswaq_app/features/cart_screen/data/models/FetchCartModel.dart';
import '../../../../../core/error/failures.dart';
import '../../../../core/cashe/shared_preferences.dart';
class CartScreenRepoImpl implements CartScreenRepo{
  CartScreenRemoteDs cartScreenRemoteDs;
  CartScreenRepoImpl(this.cartScreenRemoteDs);

  Future<String?> _getToken() async {
    return await CacheData.getData("token");
  }
  Future<Either<Failures,FetchCartModel>>fetchCart() async{
    final token = await _getToken();
    return cartScreenRemoteDs.fetchCart(token??"");
  }

  @override
  Future<Either<Failures, FetchCartModel>> updateCartQuantity(int count,String productId) async{
    final token = await _getToken();
    return cartScreenRemoteDs.updateCartQuantity(token??"",count,productId);
  }

  @override
  Future<Either<Failures, DeleteUserCartModel>> clearUserCart() async{
    final userToken = await _getToken();
    return cartScreenRemoteDs.clearUserCart(userToken??"");
  }


}