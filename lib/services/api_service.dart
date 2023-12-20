import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:plus_it_park_machine_test/models/api_model.dart';
import 'package:plus_it_park_machine_test/models/auth_model.dart';

class ApiService {
  final Dio dio = Dio(
    BaseOptions(baseUrl: "https://interview.sanjaysanthosh.me/api"),
  );
  Future<List<ApiModel>?> getDatas() async {
    try {
      Response response = await dio.get("/items");
      if (response.statusCode == 200) {
        String jsonString = json.encode(response.data);
        return apiModelFromJson(jsonString);
      }
      return null;
    } on DioException catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<AuthModel?> registerUser(
      {required String name,
      required String email,
      required String password}) async {
    try {
      Response response = await dio.post(
        "/register",
        data: json.encode({
          "name": name,
          "email": email,
          "password": password,
        }),
      );
      log("${response.statusCode} ${response.data}");
      if (response.statusCode == 200) {
        String jsonString = json.encode(response.data);
        final token = authModelFromJson(jsonString);
        return token;
      }
      return null;
    } on DioException catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<AuthModel?> loginUser(
      {required String email, required String password}) async {
    try {
      Response response = await dio.post(
        "/login",
        data: json.encode({
          "email": email,
          "password": password,
        }),
      );
      log("${response.statusCode} ${response.data}");
      if (response.statusCode == 200) {
        String jsonString = json.encode(response.data);
        final token = authModelFromJson(jsonString);
        return token;
      }
      return null;
    } on DioException catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<bool> updateUser({
    required String password,
    required String name,
    required String token,
  }) async {
    try {
      Response response = await dio.put("/update-user",
          data: json.encode(
            {
              "name": name,
              "password": password,
            },
          ),
          options: Options(headers: {
            'x-access-token': token,
          }));
      log("${response.statusCode} ${response.data}");
      if (response.statusCode == 200) {
        return true;
      }
    } on DioException catch (e) {
      log(e.toString());
    }
    return false;
  }

  Future<bool> deleteUser({
    required String token,
  }) async {
    try {
      Response response = await dio.delete("/delete-user",
          options: Options(headers: {
            'x-access-token': token,
          }));
      log("${response.statusCode} ${response.data}");
      if (response.statusCode == 200) {
        return true;
      }
    } on DioException catch (e) {
      log(e.toString());
    }
    return false;
  }

  Future<String?> protectedData({required String token}) async {
    try {
      Response response = await dio.get("/protected",
          options: Options(headers: {
            'x-access-token': token,
          }));
      if (response.statusCode == 200) {
        return response.data["message"];
      }
    } on DioException catch (e) {
      log(e.toString());
    }
    return null;
  }
}
