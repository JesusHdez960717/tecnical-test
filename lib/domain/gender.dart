enum Gender {
  male,
  female;

  static Gender valueOf(String value) {
    return Gender.values.firstWhere(
      (element) => element.name == value,
    );
  }

  bool get isMale => this == Gender.male;

  bool get isFemale => this == Gender.female;
}
