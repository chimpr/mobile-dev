// email validation logic cloned from signup_dialog
bool isValidEmail(String email) {
  final pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  return RegExp(pattern).hasMatch(email);
}

// password validation logic cloned from signup dialog
bool isValidPassword(String password) {
  final pattern = r'^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
  return RegExp(pattern).hasMatch(password);
}

// role testing from login dialog
enum UserRole { student, recruiter, unknown }

UserRole getUserRoleFromResponse(Map<String, dynamic> responseData) {
  final role = responseData["Role"];
  if (role == "Student") return UserRole.student;
  if (role == "Recruiter") return UserRole.recruiter;
  return UserRole.unknown;
}

// qr code string testing cloned from qr scanner dialog
bool isValidId(String id) {
  final regex = RegExp(r'^[a-fA-F0-9]{24}$');
  return regex.hasMatch(id);
}