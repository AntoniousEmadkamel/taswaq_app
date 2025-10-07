import 'package:dartz/dartz.dart';
import 'package:taswaq_app/core/error/failures.dart';
import 'package:taswaq_app/features/tabs/home_tab/data/models/GetWhishlistModel.dart';
import '../repositories/home_tab_repo.dart';

class GetWhishlistUsecase{
  final HomeTabRepo homeTabRepo;
  GetWhishlistUsecase(this.homeTabRepo);

  Future<Either<Failures,GetWhishlistModel>>  call() => homeTabRepo.getWhishlist() ;
}