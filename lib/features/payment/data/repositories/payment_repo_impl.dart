import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/payment_entity.dart';
import '../../domain/repositories/payment_repo.dart';
import '../data_sources/payment_remote_ds.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDataSource remoteDataSource;

  PaymentRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failures, AuthTokenResponse>> getAuthToken(String apiKey) async {
    try {
      final result = await remoteDataSource.getAuthToken(apiKey);
      return Right(result);
    } catch (e) {
      return Left(RemoteFailures(e.toString()));
    }
  }

  @override
  Future<Either<Failures, OrderResponse>> createOrder({
    required String authToken,
    required String amount,
  }) async {
    try {
      final result = await remoteDataSource.createOrder(
        authToken: authToken,
        amount: amount,
      );
      return Right(result);
    } catch (e) {
      return Left(RemoteFailures(e.toString()));
    }
  }

  @override
  Future<Either<Failures, PaymentTokenResponse>> getCardPaymentToken({
    required String authToken,
    required String orderId,
    required String amount,
    required PaymentRequest paymentRequest,
    required int integrationId,
  }) async {
    try {
      final result = await remoteDataSource.getCardPaymentToken(
        authToken: authToken,
        orderId: orderId,
        amount: amount,
        paymentRequest: paymentRequest,
        integrationId: integrationId,
      );
      return Right(result);
    } catch (e) {
      return Left(RemoteFailures(e.toString()));
    }
  }

  @override
  Future<Either<Failures, PaymentTokenResponse>> getKioskPaymentToken({
    required String authToken,
    required String orderId,
    required String amount,
    required PaymentRequest paymentRequest,
    required int integrationId,
  }) async {
    try {
      final result = await remoteDataSource.getKioskPaymentToken(
        authToken: authToken,
        orderId: orderId,
        amount: amount,
        paymentRequest: paymentRequest,
        integrationId: integrationId,
      );
      return Right(result);
    } catch (e) {
      return Left(RemoteFailures(e.toString()));
    }
  }

  @override
  Future<Either<Failures, ReferenceCodeResponse>> getReferenceCode(String kioskToken) async {
    try {
      final result = await remoteDataSource.getReferenceCode(kioskToken);
      return Right(result);
    } catch (e) {
      return Left(RemoteFailures(e.toString()));
    }
  }
}