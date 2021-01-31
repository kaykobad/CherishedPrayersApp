import 'package:cherished_prayers/data/models/models.dart';
import 'package:cherished_prayers/data/network/api_endpoints.dart';
import 'package:dartz/dartz.dart';

import 'dio_provider.dart';

class ApiProvider {
  final _dio = DioProvider();

  Future<Either<ErrorModel, AuthUserResponse>> login(LoginRequest data) async {
    try {
      Either<ErrorModel, AuthUserResponse> response = await _dio.post(ApiEndpoints.LOGIN, data: data);
      return response.fold(
          (failure) => Left(failure),
          (success) => Right(success),
      );
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return Left(ErrorModel(error, [stacktrace.toString()]));
    }
  }
}