import 'package:client_app/models/education.dart';
import 'package:client_app/models/work_experience.dart';

class User {
  // Basic user info
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
    required this.fullName,
    required this.age,
    required this.image,
    required this.bio,
    required this.jobTitle,
    required this.education,
    required this.workExperience,
    required this.projectsLink
  });

  List<Object?> get props => [fullName, age, image, bio, jobTitle, education, workExperience, projectsLink];
}