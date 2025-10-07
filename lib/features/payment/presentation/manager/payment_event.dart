import 'package:equatable/equatable.dart';

import '../../domain/entities/payment_entity.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class ProcessPaymentEvent extends PaymentEvent {
  final PaymentRequest paymentRequest;

  const ProcessPaymentEvent(this.paymentRequest);

  @override
  List<Object> get props => [paymentRequest];
}