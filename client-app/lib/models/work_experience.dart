class WorkExperience {
  String startYear;
  String endYear;
  String businessName;
  
  WorkExperience({required this.startYear, required this.endYear, required this.businessName});

  WorkExperience.fromJson(Map<String, dynamic> json)
      : startYear = json['startYear'],
        endYear = json['endYear'],
        businessName = json['businessName'];

  Map<String, dynamic> toJson() {
    return {
      'startYear': startYear,
      'endYear': endYear,
      'businessName': businessName,
    };
  }
}