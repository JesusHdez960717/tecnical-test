import 'package:dio/dio.dart';
import 'package:tecnical_test/api/api_response.dart';

class ApiTest {
  Dio dio = Dio();

  Future<List<UserResponse>> fetch({int page = 0, int size = 10}) async {
    String path =
        "https://randomuser.me/api/?page=$page&results=$size&inc=name,location,email,picture";
    Response response = await dio.get(path);

    return ApiResponse.fromJson(response.data!).results;
  }
}
