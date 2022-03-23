class Education {
  String graduationYear;
  String institution;

  Education({required this.graduationYear, required this.institution});

  Education.fromJson(Map<String, dynamic> json)
      : graduationYear = json['graduationYear'],
        institution = json['institution'];

  Map<String, dynamic> toJson() {
    return {
      'graduationYear': graduationYear,
      'institution': institution,
    };
  }
}