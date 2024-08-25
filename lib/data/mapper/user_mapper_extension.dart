import 'package:tecnical_test/data/model/model_exporter.dart';
import 'package:tecnical_test/domain/domain_exporter.dart';

extension UserListMapperExtension on List<UserModel> {
  List<UserDomain> toUserDomain() {
    return map(
      (singleUserModel) => singleUserModel.toUserDomain(),
    ).toList();
  }
}

extension UserMapperExtension on UserModel {
  UserDomain toUserDomain() {
    return UserDomain(
      name: NameDomain(
        title: name.title,
        first: name.first,
        last: name.last,
      ),
      location: LocationDomain(
        street: StreetDomain(
          number: location.street.number,
          name: location.street.name,
        ),
        city: location.city,
        state: location.state,
        country: location.country,
        postcode: location.postcode,
        coordinates: CoordinatesDomain(
          latitude: location.coordinates.latitude,
          longitude: location.coordinates.longitude,
        ),
        timezone: TimezoneDomain(
          offset: location.timezone.offset,
          description: location.timezone.description,
        ),
      ),
      email: email,
      picture: PictureDomain(
        large: picture.large,
        medium: picture.medium,
        thumbnail: picture.thumbnail,
      ),
    );
  }
}
