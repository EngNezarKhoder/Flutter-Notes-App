String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return "The field is empty";
  }
  if (value.length < 6) {
    return 'Password must be at least 6 characters long';
  }
  if (!RegExp(r'[A-Z]').hasMatch(value)) {
    return 'Password must contain at least one uppercase letter';
  }
  if (!RegExp(r'[0-9]').hasMatch(value)) {
    return 'Password must contain at least one number';
  }
  return null;
}

String? validateEmail(String? value) {
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (value == null || value.isEmpty) {
    return "The field is empty";
  }
  if (!emailRegex.hasMatch(value)) {
    return 'Please enter a valid email address';
  }
  return null;
}

String? validateUserName(String? value) {
  if (value == null || value.isEmpty) {
    return "The field is empty";
  }
  if (value.length < 4) {
    return 'username must be at least 4 characters long';
  }
  return null;
}
