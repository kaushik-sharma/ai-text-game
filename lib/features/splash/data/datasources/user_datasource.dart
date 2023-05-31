import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/constants/urls.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/usecases/usecase.dart';

abstract class UserDataSource {
  Future<NoParams> createUser(String deviceId);
}

class UserDataSourceImpl implements UserDataSource {
  @override
  Future<NoParams> createUser(String deviceId) async {
    final Dio dio = Dio();
    final Response<Map<String, dynamic>> response = await dio.post(
      createUserUrl,
      data: jsonEncode({
        'deviceId': deviceId,
      }),
    );

    if (response.statusCode != 200) {
      throw const ServerException();
    }

    return const NoParams();
  }
}
