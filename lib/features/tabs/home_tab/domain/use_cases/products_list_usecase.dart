import 'package:dartz/dartz.dart';
import 'package:taswaq_app/core/error/failures.dart';
import 'package:taswaq_app/features/tabs/products_tab/data/models/ProductListModel.dart';

import '../repositories/home_tab_repo.dart';

class ProductsListUseCase{
final HomeTabRepo homeTabRepo;
ProductsListUseCase(this.homeTabRepo);

Future<Either<Failures,ProductListModel>>  call() => homeTabRepo.fetchProducts() ;
}