import 'package:bloc/bloc.dart';
import 'package:taswaq_app/core/error/failures.dart';
import 'package:taswaq_app/features/tabs/home_tab/data/models/AddProductToWhishlistModel.dart';
import 'package:taswaq_app/features/cart_screen/data/models/FetchCartModel.dart';
import 'package:taswaq_app/features/tabs/home_tab/data/models/GetWhishlistModel.dart';
import 'package:taswaq_app/features/tabs/home_tab/domain/use_cases/add_product_to_whishlist_usecase.dart';
import 'package:taswaq_app/features/tabs/home_tab/domain/use_cases/add_to_cart_usecase.dart';
import 'package:taswaq_app/features/tabs/home_tab/domain/use_cases/categories_usecase.dart';
import 'package:taswaq_app/features/tabs/home_tab/domain/use_cases/get_whishlist_usecase.dart';
import 'package:taswaq_app/features/tabs/home_tab/domain/use_cases/remove_product_from_whishlist_usecase.dart';
import 'package:taswaq_app/features/tabs/products_tab/data/models/ProductListModel.dart';
import 'package:taswaq_app/features/tabs/home_tab/domain/use_cases/products_list_usecase.dart';
import '../../data/models/AddToCartModel.dart';
import '../../data/models/CategoriesModel.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  ProductsListUseCase getProductsUseCase;
  CategoriesUseCase getCategoriesUseCase;
  GetWhishlistUsecase getWhishlistUsecase;
  AddProductToWhishlistUsecase addProductToWhishlistUsecase;
  RemoveProductFromWhishlistUsecase removeProductFromWhishlistUsecase;
  AddToCartUsecase addToCartUsecase;
  static List<String>? iDs = [];

  HomeBloc(this.getProductsUseCase,this.getCategoriesUseCase,this.getWhishlistUsecase,this.addProductToWhishlistUsecase,this.removeProductFromWhishlistUsecase,this.addToCartUsecase) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async{
      if(event is FetchProductListEvent){
      emit(state.copyWith(homeState:HomeStates.loading,));
      var result=await getProductsUseCase.call();
      result.fold((l) {
        emit(state.copyWith(homeState: HomeStates.error,productFailure: l));
      }, (r) {
        emit(state.copyWith(homeState: HomeStates.success,productListModel: r));
      },);
      }
      if(event is FetchCategoriesEvent){
        emit(state.copyWith(homeState:HomeStates.loading,));
        var result=await getCategoriesUseCase.call();
        result.fold((l) {
          emit(state.copyWith(homeState: HomeStates.error,productFailure: l));
        }, (r) {
          emit(state.copyWith(homeState: HomeStates.success,categoriesModel: r));
        },);
      }
      if(event is FetchWhishlistEvent){
        emit(state.copyWith(homeState:HomeStates.loading,));
        var result=await getWhishlistUsecase.call();
        result.fold((l) {
          emit(state.copyWith(homeState: HomeStates.error,productFailure: l));
        }, (r) {
            for (int i = 0; i < r.data!.length; i++) {
            iDs?.add(r.data![i].id!);
            }
          emit(state.copyWith(homeState: HomeStates.success,getWhishlistModel: r, iDs: iDs));
        },);
      }
      if(event is AddProductToWhishlistEvent){
        emit(state.copyWith(homeState:HomeStates.loading,));
        var result=await addProductToWhishlistUsecase.call(event.productId??"");
        result.fold((l) {
          emit(state.copyWith(homeState: HomeStates.error,productFailure: l));
        }, (r) {
          iDs?.add(event.productId);
          emit(state.copyWith(homeState: HomeStates.success,addProductToWhishlistModel: r,iDs: iDs));
        },);
      }
      if(event is RemoveProductFromWhishlistEvent){
        emit(state.copyWith(homeState:HomeStates.loading,));
        var result=await removeProductFromWhishlistUsecase.call(event.productId??"");
        result.fold((l) {
          emit(state.copyWith(homeState: HomeStates.error,productFailure: l));
        }, (r) {
          iDs?.remove(event.productId);
          emit(state.copyWith(homeState: HomeStates.success,removeProductFromWhishlistModel: r,iDs: iDs));
        },);
      }
      if (event is ChangeFavIcon) {
        emit(state.copyWith(homeState:HomeStates.success, isFav: (event.isFave)));
      }

      if(event is AddToCartEvent){
        emit(state.copyWith(homeState: HomeStates.loading));
        var result=await addToCartUsecase.call(event.productId);
        result.fold((l) {
          emit(state.copyWith(homeState: HomeStates.error,productFailure: l));
        }, (r) {
          emit(state.copyWith(homeState: HomeStates.success,addToCartModel: r));

        },);
      }

    });
  }
}