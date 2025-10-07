import 'package:dartz/dartz.dart';
import 'package:taswaq_app/core/error/failures.dart';
import 'package:taswaq_app/features/tabs/home_tab/data/models/CategoriesModel.dart';
import '../repositories/home_tab_repo.dart';

class CategoriesUseCase{
  final HomeTabRepo homeTabRepo;
  CategoriesUseCase(this.homeTabRepo);

  Future<Either<Failures,CategoriesModel>>  call() => homeTabRepo.fetchCategories() ;
}