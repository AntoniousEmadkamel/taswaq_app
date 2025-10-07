import 'package:dartz/dartz.dart';
import 'package:taswaq_app/core/error/failures.dart';
import 'package:taswaq_app/features/tabs/home_tab/domain/repositories/home_tab_repo.dart';
import '../../data/models/AddToCartModel.dart';

class AddToCartUsecase{
   HomeTabRepo homeTabRepo;
   AddToCartUsecase(this.homeTabRepo);

   Future<Either<Failures,AddToCartModel>>call(String productId)=>homeTabRepo.AddToCart(productId);
}