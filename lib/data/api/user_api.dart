import 'package:dio/dio.dart';
import 'package:tecnical_test/data/model/model_exporter.dart';

class UserApi {
  Dio dio = Dio();

  Future<List<UserModel>> fetch({int? page = 0, int? size = 10}) async {
    //hace la peticion a la api con la pagina y el tamanno determinado
    //NOTA: solo pide de la api los campos que se necesitan
    String path =
        'https://randomuser.me/api/?page=$page&results=$size&inc=name,location,email,picture';

    Response response = await dio.get(path);

    return UserApiResponse.fromJson(response.data!).results;
  }
}
