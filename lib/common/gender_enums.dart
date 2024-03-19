enum Gender {
  male,
  female,
}

String genderToString(Gender gender) {
  switch (gender) {
    case Gender.male:
      return 'Male';
    case Gender.female:
      return 'Female';
    default:
      return "Rather Not Say";
  }
}
