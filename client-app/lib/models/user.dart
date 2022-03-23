import 'package:client_app/models/education.dart';
import 'package:client_app/models/work_experience.dart';

class User {
  // Basic user info
  final String email;
  final String password;
  final String fullName;
  final int age;
  final String image;
  final String bio;

  // Work-related info
  final String jobTitle;
  final List<Education> education;
  final List<WorkExperience> workExperience;
  final String projectsLink;

  const User({
    required this.email,
    required this.password,
    required this.fullName,
    required this.age,
    required this.image,
    required this.bio,
    required this.jobTitle,
    required this.education,
    required this.workExperience,
    required this.projectsLink
  });

  User.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        password = json['password'],
        fullName = json['fullName'],
        age = json['age'],
        image = json['image'],
        bio = json['bio'],
        jobTitle = json['jobTitle'],
        education = json['education'].map((education) => Education.fromJson(education)).toList(),
        workExperience = json['workExperience'].map((workExperience) => WorkExperience.fromJson(workExperience)).toList(),
        projectsLink = json['projectsLink'];

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'fullName': fullName,
      'age': age,
      'image': image,
      'bio': bio,
      'jobTitle': jobTitle,
      'education': _createEducationJson(education),
      'workExperience': _createWorkExperienceJson(workExperience),
      'projectsLink':projectsLink,
    };
  }

  List<Object?> get props => [fullName, age, image, bio, jobTitle, education, workExperience, projectsLink];

  List<Map <String, dynamic>> _createEducationJson(List<Education> education) {
    List<Map <String, dynamic>> educationJson = [];
    for (Education educationObj in education) {
      educationJson.add(educationObj.toJson());
    }
    return educationJson;
  }

  List<Map <String, dynamic>> _createWorkExperienceJson(List<WorkExperience> workExperience) {
    List<Map <String, dynamic>> workExperienceJson = [];
    for (WorkExperience workExperienceObj in workExperience) {
      workExperienceJson.add(workExperienceObj.toJson());
    }
    return workExperienceJson;
  }
}