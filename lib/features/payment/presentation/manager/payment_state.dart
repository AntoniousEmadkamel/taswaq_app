// abstract class PaymentStates {}
//
// class InitPaymentState extends PaymentStates {}
//
// class LoadingAuthTokenPaymentState extends PaymentStates {}
//
// class SuccessAuthTokenPaymentState extends PaymentStates {}
//
// class ErrorAuthTokenPaymentState extends PaymentStates {}
//
// class LoadingOrderIdPaymentState extends PaymentStates {}
//
// class SuccessOrderIdPaymentState extends PaymentStates {}
//
// class ErrorOrderIdPaymentState extends PaymentStates {}
//
// class LoadingRequestTokenCardPaymentState extends PaymentStates {}
//
// class SuccessRequestTokenCardPaymentState extends PaymentStates {}
//
// class ErrorRequestTokenCardPaymentState extends PaymentStates {}
//
// class LoadingRequestTokenKioskPaymentState extends PaymentStates {}
//
// class SuccessRequestTokenKioskPaymentState extends PaymentStates {}
//
// class ErrorRequestTokenKioskPaymentState extends PaymentStates {}
//
// class LoadingReferenceCodePaymentState extends PaymentStates {}
//
// class SuccessReferenceCodePaymentState extends PaymentStates {}
//
// class ErrorReferenceCodePaymentState extends PaymentStates {}

// lib/features/payment/presentation/bloc/payment_state.dart

// lib/features/payment/presentation/manager/payment_state.dart
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object?> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentCardTokenGenerated extends PaymentState {
  final String cardToken;
  final String orderId;
  final String authToken;

  const PaymentCardTokenGenerated({
    required this.cardToken,
    required this.orderId,
    required this.authToken,
  });

  @override
  List<Object> get props => [cardToken, orderId, authToken];
}

class PaymentKioskTokenGenerated extends PaymentState {
  final String kioskToken;
  final String referenceCode;

  const PaymentKioskTokenGenerated({
    required this.kioskToken,
    required this.referenceCode,
  });

  @override
  List<Object> get props => [kioskToken, referenceCode];
}

class PaymentError extends PaymentState {
  final Failures failure;

  const PaymentError(this.failure);

  @override
  List<Object> get props => [failure];
}