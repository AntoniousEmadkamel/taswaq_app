import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/constants.dart';
import '../../domain/use_cases/create_order_usecase.dart';
import '../../domain/use_cases/get_auth_token_usecase.dart';
import '../../domain/use_cases/get_card_payment_key_usecase.dart';
import '../../domain/use_cases/get_kiosk_payment_token_usecase.dart';
import '../../domain/use_cases/get_refrence_code_usecase.dart';
import 'payment_event.dart';
import 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final GetAuthTokenUsecase getAuthTokenUsecase;
  final CreateOrderUsecase createOrderUsecase;
  final GetCardPaymentTokenUsecase getCardPaymentTokenUsecase;
  final GetKioskPaymentTokenUsecase getKioskPaymentTokenUsecase;
  final GetReferenceCodeUsecase getReferenceCodeUsecase;

  PaymentBloc({
    required this.getAuthTokenUsecase,
    required this.createOrderUsecase,
    required this.getCardPaymentTokenUsecase,
    required this.getKioskPaymentTokenUsecase,
    required this.getReferenceCodeUsecase,
  }) : super(PaymentInitial()) {
    on<ProcessPaymentEvent>(_processPayment);
  }

  Future<void> _processPayment(
      ProcessPaymentEvent event,
      Emitter<PaymentState> emit,
      ) async {
    emit(PaymentLoading());

    // Step 1: Get Auth Token
    final authResult = await getAuthTokenUsecase(Constants.API_KEY);

    await authResult.fold(
          (failure) async => emit(PaymentError(failure)),
          (authResponse) async {
        final authToken = authResponse.token;
        Constants.AUTH_TOKEN = authToken;

        // Step 2: Create Order
        final orderResult = await createOrderUsecase(
          authToken: authToken,
          amount: event.paymentRequest.amount,
        );

        await orderResult.fold(
              (failure) async => emit(PaymentError(failure)),
              (orderResponse) async {
            final orderId = orderResponse.orderId;
            Constants.ORDER_ID = orderId;

            // Step 3: Get Card Payment Token (for visa screen)
            final cardTokenResult = await getCardPaymentTokenUsecase(
              authToken: authToken,
              orderId: orderId,
              amount: event.paymentRequest.amount,
              paymentRequest: event.paymentRequest,
              integrationId: Constants.INTERGRATIONCARDID.toInt(),
            );

            await cardTokenResult.fold(
                  (failure) async => emit(PaymentError(failure)),
                  (cardTokenResponse) async {
                final cardToken = cardTokenResponse.token;
                Constants.REQUEST_TOKEN_CARD = cardToken;

                // Emit success with card token for navigation to visa screen
                emit(PaymentCardTokenGenerated(
                  cardToken: cardToken,
                  orderId: orderId,
                  authToken: authToken,
                ));

                // Step 4: Get Kiosk Payment Token (in background)
                final kioskTokenResult = await getKioskPaymentTokenUsecase(
                  authToken: authToken,
                  orderId: orderId,
                  amount: event.paymentRequest.amount,
                  paymentRequest: event.paymentRequest,
                  integrationId: Constants.INTERGRATIONKIOSKID.toInt(),
                );

                await kioskTokenResult.fold(
                      (failure) async {
                    // Don't emit error for kiosk, as card payment is already successful
                    print("Kiosk token generation failed: ${failure.message}");
                  },
                      (kioskTokenResponse) async {
                    final kioskToken = kioskTokenResponse.token;
                    Constants.REQUEST_TOKEN_KIOSK = kioskToken;

                    // Step 5: Get Reference Code
                    final refCodeResult = await getReferenceCodeUsecase(kioskToken);

                    refCodeResult.fold(
                          (failure) {
                        print("Reference code generation failed: ${failure.message}");
                      },
                          (refCodeResponse) {
                        final refCode = refCodeResponse.referenceCode;
                        Constants.REF_CODE = refCode;

                        print("=== Payment Tokens Summary ===");
                        print("AUTH_TOKEN: ${Constants.AUTH_TOKEN}");
                        print("ORDER_ID: ${Constants.ORDER_ID}");
                        print("REQUEST_TOKEN_CARD: ${Constants.REQUEST_TOKEN_CARD}");
                        print("REQUEST_TOKEN_KIOSK: ${Constants.REQUEST_TOKEN_KIOSK}");
                        print("REF_CODE: ${Constants.REF_CODE}");
                        print("=============================");
                      },
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}