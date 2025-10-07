import 'package:dartz/dartz.dart';
import 'package:taswaq_app/core/error/failures.dart';
import 'package:taswaq_app/features/cart_screen/domain/repositories/cart_screen_repo.dart';
import 'package:taswaq_app/features/cart_screen/data/models/FetchCartModel.dart';
import 'package:taswaq_app/features/tabs/home_tab/domain/repositories/home_tab_repo.dart';

import '../repositories/cart_screen_repo.dart';

class UpdateCartQuantityUsecase{
  CartScreenRepo cartScreenRepo;
  UpdateCartQuantityUsecase(this.cartScreenRepo);

  Future<Either<Failures,FetchCartModel>>call(int count,String productId)=>cartScreenRepo.updateCartQuantity(count,productId);
}