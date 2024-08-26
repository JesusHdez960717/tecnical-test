import 'gender.dart';

class UserDomain {
  Gender gender;
  NameDomain name;
  LocationDomain location;
  String email;
  PictureDomain picture;

  UserDomain({
    required this.gender,
    required this.name,
    required this.location,
    required this.email,
    required this.picture,
  });
}

class NameDomain {
  String title;
  String first;
  String last;

  NameDomain({required this.title, required this.first, required this.last});

  String get fullName => '$title $first $last';
}

class LocationDomain {
  StreetDomain street;
  String city;
  String state;
  String country;
  dynamic postcode; // Puede ser String o int dependiendo del país
  CoordinatesDomain coordinates;
  TimezoneDomain timezone;

  LocationDomain({
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.postcode,
    required this.coordinates,
    required this.timezone,
  });
}

class StreetDomain {
  int number;
  String name;

  StreetDomain({required this.number, required this.name});
}

class CoordinatesDomain {
  double latitude;
  double longitude;

  CoordinatesDomain({required this.latitude, required this.longitude});
}

class TimezoneDomain {
  String offset;
  String description;

  TimezoneDomain({required this.offset, required this.description});
}

class PictureDomain {
  String large;
  String medium;
  String thumbnail;

  PictureDomain({
    required this.large,
    required this.medium,
    required this.thumbnail,
  });
}

class InfoDomain {
  String seed;
  int results;
  int page;
  String version;

  InfoDomain({
    required this.seed,
    required this.results,
    required this.page,
    required this.version,
  });
}
