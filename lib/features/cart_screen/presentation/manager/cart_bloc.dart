import 'package:bloc/bloc.dart';
import 'package:taswaq_app/features/cart_screen/domain/use_cases/clear_cart_usecase.dart';
import 'package:taswaq_app/features/cart_screen/domain/use_cases/update_cart_quantity_usecase.dart';
import '../../domain/use_cases/fetch_cart_usecase.dart';
import 'cart_state.dart';
part 'cart_event.dart';

class CartBloc extends Bloc<CartEvent, CartState> {

  FetchCartUsecase fetchCartUsecase;
  UpdateCartQuantityUsecase updateCartQuantityUsecase;
  ClearCartUsecase clearCartUsecase;
  static List<String>? iDs = [];

  CartBloc(this.fetchCartUsecase,this.updateCartQuantityUsecase,this.clearCartUsecase) : super(HomeInitial()) {
    on<CartEvent>((event, emit) async{
      if(event is FetchCartEvent){
        emit(state.copyWith(cartStates:CartStates.loading));
        var result=await fetchCartUsecase.call();
        result.fold((l) {
          emit(state.copyWith(cartStates:CartStates.error,productFailure: l));
        }, (r) {
          emit(state.copyWith(cartStates: CartStates.success,cartModel: r));

        },);
      }
      if(event is UpdateCartQuantityEvent){
        emit(state.copyWith(cartStates:CartStates.loading));
        var result=await updateCartQuantityUsecase.call(event.count??0,event.productId??"");
        result.fold((l) {
          emit(state.copyWith(cartStates:CartStates.error,productFailure: l));
        }, (r) {
          emit(state.copyWith(cartStates: CartStates.success,cartModel: r));
        },);
      }
      if(event is ClearUserCartEvent){
        emit(state.copyWith(cartStates:CartStates.loading));
        var result=await clearCartUsecase.call();
        result.fold((l) {
          emit(state.copyWith(cartStates:CartStates.error,productFailure: l));
        }, (r) {
          emit(state.copyWith(cartStates: CartStates.success,deleteUserCartModel: r,));

        },);
      }

    });
  }
}