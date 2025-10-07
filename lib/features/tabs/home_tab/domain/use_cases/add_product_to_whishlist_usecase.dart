import 'package:dartz/dartz.dart';
import 'package:taswaq_app/core/error/failures.dart';
import 'package:taswaq_app/features/tabs/home_tab/data/models/AddProductToWhishlistModel.dart';
import '../repositories/home_tab_repo.dart';

class AddProductToWhishlistUsecase{
  final HomeTabRepo homeTabRepo;
  AddProductToWhishlistUsecase(this.homeTabRepo);

  Future<Either<Failures,AddProductToWhishlistModel>>call(String productId) => homeTabRepo.AddProductToWhishlist(productId) ;
}