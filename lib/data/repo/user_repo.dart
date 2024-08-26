import 'package:tecnical_test/data/api/api_exporter.dart';
import 'package:tecnical_test/data/mapper/user_mapper_extension.dart';
import 'package:tecnical_test/domain/domain_exporter.dart';

class UserRepo {
  UserApi api = UserApi();

  Future<List<UserDomain>> fetch({int? page, int? size}) async {
    return (await api.fetch(
      page: page,
      size: size,
    ))
        .toUserDomain();
  }
}
