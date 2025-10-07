
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taswaq_app/config/routes/app_route.dart';
import 'package:taswaq_app/features/cart_screen/data/data_sources/cart_screen_remote_ds_impl.dart';
import 'package:taswaq_app/features/cart_screen/data/repositories/cart_screen_repo_impl.dart';
import 'package:taswaq_app/features/cart_screen/domain/use_cases/update_cart_quantity_usecase.dart';
import 'package:taswaq_app/features/cart_screen/presentation/widgets/cart_item.dart';
import 'package:taswaq_app/core/utils/app_colors.dart';
import 'package:taswaq_app/features/payment/domain/use_cases/create_order_usecase.dart';
import 'package:taswaq_app/features/payment/domain/use_cases/get_auth_token_usecase.dart';
import 'package:taswaq_app/features/payment/domain/use_cases/get_card_payment_key_usecase.dart';
import 'package:taswaq_app/features/payment/domain/use_cases/get_refrence_code_usecase.dart';
import 'package:taswaq_app/features/payment/presentation/manager/payment_bloc.dart';
import 'package:taswaq_app/features/payment/presentation/manager/payment_event.dart';
import 'package:taswaq_app/features/payment/presentation/manager/payment_state.dart';
import '../../../../core/api/api_manager.dart';
import '../../../payment/data/data_sources/payment_remote_ds_impl.dart';
import '../../../payment/data/repositories/payment_repo_impl.dart';
import '../../../payment/domain/entities/payment_entity.dart';
import '../../../payment/domain/use_cases/get_kiosk_payment_token_usecase.dart';
import '../../../payment/presentation/manager/payment_state.dart';
import '../../domain/use_cases/clear_cart_usecase.dart';
import '../../domain/use_cases/fetch_cart_usecase.dart';
import '../manager/cart_bloc.dart';
import '../manager/cart_state.dart';
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Create payment repository and use cases
    final paymentDataSource = PaymentRemoteDataSourceImpl();
    final paymentRepository = PaymentRepositoryImpl(paymentDataSource);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => CartBloc(
                FetchCartUsecase(
                  CartScreenRepoImpl(CartScreenRemoteDsImpl(ApiManager())),
                ),
                UpdateCartQuantityUsecase(
                  CartScreenRepoImpl(CartScreenRemoteDsImpl(ApiManager())),
                ),
                  ClearCartUsecase(CartScreenRepoImpl(CartScreenRemoteDsImpl(ApiManager())))
              )..add(FetchCartEvent()),
        ),
        BlocProvider(
          create: (context) => PaymentBloc(
            getAuthTokenUsecase: GetAuthTokenUsecase(paymentRepository),
            createOrderUsecase: CreateOrderUsecase(paymentRepository),
            getCardPaymentTokenUsecase: GetCardPaymentTokenUsecase(paymentRepository),
            getKioskPaymentTokenUsecase: GetKioskPaymentTokenUsecase(paymentRepository),
            getReferenceCodeUsecase: GetReferenceCodeUsecase(paymentRepository),
          ),
        ),
      ],
      child: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          if (state.cartStates == CartStates.loading) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder:
                  (context) => const AlertDialog(
                    title: Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.grey,
                      ),
                    ),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
            );
          } else if (state.cartStates == CartStates.success) {
            Navigator.pop(context);
          } else if (state.cartStates == CartStates.error) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder:
                  (context) => AlertDialog(
                    title: const Text("Error", style: TextStyle(fontSize: 18)),
                    elevation: 0,
                    content: SizedBox(
                      height: 450,
                      child: Column(
                        children: [
                          Text(
                            state.productFailure?.message ??
                                "unknown error occurred",
                            style: const TextStyle(color: Colors.red),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      ),
                    ),
                  ),
            );
          }
        },
        builder: (context, state) {
          return BlocListener<PaymentBloc, PaymentState>(
            listener: (context, paymentState) {
              if (paymentState is PaymentLoading) {
                // Show loading dialog for payment processing
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        content: Row(
                          children: [
                            const CircularProgressIndicator(),
                            const SizedBox(width: 20),
                            Text(
                              "Processing payment...",
                              style: GoogleFonts.poppins(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                );
              }
              else if (paymentState is PaymentCardTokenGenerated) {
                // Close loading dialog and navigate to visa screen
                Navigator.pop(context); // Close loading dialog
                // Add a small delay to ensure token is properly set
                Future.delayed(Duration(milliseconds: 500), () {
                  Navigator.pushNamed(context, AppRoutes.visa);
                });
              }
              else if (paymentState is PaymentError) {
                // Close loading dialog and show error
                Navigator.pop(context); // Close loading dialog
                showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: const Text("Payment Error"),
                        content: const Text(
                          "Failed to process payment. Please try again.",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("OK"),
                          ),
                        ],
                      ),
                );
              }
            },
            child: Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(CupertinoIcons.search),
                  ),
                  IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.cart)),
                ],
                elevation: 0,
                backgroundColor: Colors.transparent,
                centerTitle: true,
                title: Text(
                  "Cart",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff06004f),
                  ),
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemBuilder:
                          (context, index) => AddToCartItem(
                            product: state.cartModel?.data?.products?[index],
                          ),
                      separatorBuilder:
                          (context, index) => SizedBox(height: 10),
                      itemCount: state.cartModel?.data?.products?.length ?? 0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Total Price",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Color(0x9906004F),
                              ),
                            ),
                            Text(
                              "EGP ${state.cartModel?.data?.totalCartPrice?.toString() ?? 0}",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Color(0xff06004F),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 240,
                          height: 60,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.blueColor,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 15),
                            ),
                            onPressed: () {
                              // Start payment process with user details
                              // You might want to get these from user input or stored data
                              final paymentBloc = context.read<PaymentBloc>();
                              final cartBloc = context.read<CartBloc>();
                              final totalAmount = (state.cartModel?.data?.totalCartPrice ?? 0) * 100; //Convert to cents
                              paymentBloc.add(ProcessPaymentEvent(PaymentRequest(
                                    email: "emadantonious9@gmail.com",
                                    phone: "01220156988",
                                    firstName: "Antonious",
                                    lastName: "Emad",
                                    amount: totalAmount.toString()
                              )));
                              cartBloc.add(ClearUserCartEvent());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "check out",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                ),
                                Icon(CupertinoIcons.arrow_right),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}