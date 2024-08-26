class UserApiResponse {
  List<UserModel> results;
  InfoModel info;

  UserApiResponse({required this.results, required this.info});

  factory UserApiResponse.fromJson(Map<String, dynamic> json) {
    return UserApiResponse(
      results: List<UserModel>.from(
        json['results'].map(
          (result) => UserModel.fromJson(result),
        ),
      ),
      info: InfoModel.fromJson(json['info']),
    );
  }
}

class UserModel {
  String gender;
  NameModel name;
  LocationModel location;
  String email;
  PictureModel picture;

  UserModel({
    required this.gender,
    required this.name,
    required this.location,
    required this.email,
    required this.picture,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      gender: json['gender'],
      name: NameModel.fromJson(json['name']),
      location: LocationModel.fromJson(json['location']),
      email: json['email'],
      picture: PictureModel.fromJson(json['picture']),
    );
  }
}

class NameModel {
  String title;
  String first;
  String last;

  NameModel({required this.title, required this.first, required this.last});

  factory NameModel.fromJson(Map<String, dynamic> json) {
    return NameModel(
      title: json['title'],
      first: json['first'],
      last: json['last'],
    );
  }
}

class LocationModel {
  StreetModel street;
  String city;
  String state;
  String country;
  dynamic postcode; // Puede ser String o int dependiendo del país
  CoordinatesModel coordinates;
  TimezoneModel timezone;

  LocationModel({
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.postcode,
    required this.coordinates,
    required this.timezone,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      street: StreetModel.fromJson(json['street']),
      city: json['city'],
      state: json['state'],
      country: json['country'],
      postcode: json['postcode'],
      coordinates: CoordinatesModel.fromJson(json['coordinates']),
      timezone: TimezoneModel.fromJson(json['timezone']),
    );
  }
}

class StreetModel {
  int number;
  String name;

  StreetModel({required this.number, required this.name});

  factory StreetModel.fromJson(Map<String, dynamic> json) {
    return StreetModel(
      number: json['number'],
      name: json['name'],
    );
  }
}

class CoordinatesModel {
  double latitude;
  double longitude;

  CoordinatesModel({required this.latitude, required this.longitude});

  factory CoordinatesModel.fromJson(Map<String, dynamic> json) {
    return CoordinatesModel(
      latitude: double.tryParse(json['latitude']) ?? 0.0,
      longitude: double.tryParse(json['longitude']) ?? 0.0,
    );
  }
}

class TimezoneModel {
  String offset;
  String description;

  TimezoneModel({required this.offset, required this.description});

  factory TimezoneModel.fromJson(Map<String, dynamic> json) {
    return TimezoneModel(
      offset: json['offset'],
      description: json['description'],
    );
  }
}

class PictureModel {
  String large;
  String medium;
  String thumbnail;

  PictureModel({
    required this.large,
    required this.medium,
    required this.thumbnail,
  });

  factory PictureModel.fromJson(Map<String, dynamic> json) {
    return PictureModel(
      large: json['large'],
      medium: json['medium'],
      thumbnail: json['thumbnail'],
    );
  }
}

class InfoModel {
  String seed;
  int results;
  int page;
  String version;

  InfoModel({
    required this.seed,
    required this.results,
    required this.page,
    required this.version,
  });

  factory InfoModel.fromJson(Map<String, dynamic> json) {
    return InfoModel(
      seed: json['seed'],
      results: json['results'],
      page: json['page'],
      version: json['version'],
    );
  }
}
