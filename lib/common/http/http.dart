import 'package:seller/common/errors/errors.dart';
import 'package:seller/common/http/error.dart';
import 'package:seller/common/http/res.dart';
import 'package:seller/common/http/status.dart';
// import 'package:seller/common/models/paginations.dart';
import 'package:seller/config/hosts.dart';
import 'package:seller/core/auth/bloc/bloc_auth.dart';
import 'package:dio/dio.dart';

abstract class HttpService {
  final dio = Dio();
  Future<dynamic> get(String path, {int? timeOut}) async {
    final token = AuthBloc().getToken();
    final options = BaseOptions(
      baseUrl: host,
      // queryParameters: paginations?.toMap(),
      connectTimeout: Duration(milliseconds: timeOut ?? 3000),
      receiveTimeout: Duration(milliseconds: timeOut ?? 3000),
      method: "GET",
      headers: {
        'accept': 'application/json',
        if (token != null) 'authorization': "Bearer ${token.token}",
      },
    );
    try {
      final response = await Dio(options).get(
        path,
      );
      final result = Responses.fromMap(response.data);
      if (result.status == httpStatusFailed) {
        throw HttpError(message: result.message ?? "Failed to get data");
      }
      if (result.data is Map<String, dynamic>) {
        return result.data;
      }
      if (result.data is String) {
        return result.data;
      }
      if (result.data is List) {
        return result.data;
      }
      throw errFailedToParseResponeData;
    } on DioError catch (e) {
      throw _errorHandling(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<Responses> post(String path, {Map<String, dynamic>? body}) async {
    try {
      final token = AuthBloc().getToken();
      final options = BaseOptions(
        baseUrl: host,
        connectTimeout: const Duration(milliseconds: 3000),
        receiveTimeout: const Duration(milliseconds: 3000),
        method: "POST",
        headers: {
          'accept': 'application/json',
          if (token != null) 'authorization': "Bearer ${token.token}",
        },
      );
      final response = await Dio(options).post(
        path,
        data: body,
      );

      final result = Responses.fromMap(response.data);
      if (result.error.isNotEmpty) {
        throw result.error;
      }
      if (result.status == httpStatusFailed) {
        throw HttpError(message: result.message ?? "Failed to post data");
      }
      return result;
    } on DioError catch (e) {
      throw _errorHandling(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<Responses> postImage(String path, {dynamic body}) async {
    try {
      final token = AuthBloc().getToken();
      final options = BaseOptions(
        baseUrl: uploadfile,
        connectTimeout: const Duration(milliseconds: 3000),
        receiveTimeout: const Duration(milliseconds: 3000),
        method: "POST",
        headers: {
          'accept': 'application/json',
          if (token != null) 'authorization': "Bearer ${token.token}",
        },
      );
      final response = await Dio(options).post(
        path,
        data: body,
      );

      final result = Responses.fromMap(response.data);
      if (result.error.isNotEmpty) {
        throw result.error;
      }
      if (result.status == httpStatusFailed) {
        throw HttpError(message: result.message ?? "Failed to post data");
      }
      return result;
    } on DioError catch (e) {
      throw _errorHandling(e);
    } catch (e) {
      rethrow;
    }
  }

  Errors _errorHandling(DioError error) {
    return _map[error.type] ??
        const HttpError(message: 'Tidak terdeteksi adanya koneksi');
  }
}

const _map = {
  DioExceptionType.sendTimeout: HttpError(message: 'Koneksi Anda bermasalah'),
  DioExceptionType.connectionTimeout:
      HttpError(message: 'Koneksi Anda lambat, pastikan koneksi Anda stabil'),
  // DioExceptionType.other:
  DioExceptionType.unknown:
      HttpError(message: ' Tidak ada koneksi, silahkan cek koneksi Anda'),
  // DioExceptionType.response: HttpError(
  DioExceptionType.badResponse: HttpError(
      message: 'Tidak ada koneksi'), //TODO: jika error maka masuk ke sini
};
