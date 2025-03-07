String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter an email';
  }
  // Regular expression for validating an email
  final RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  if (!emailRegExp.hasMatch(value)) {
    return 'Please enter a valid email';
  }
  return '';
}

String? phoneValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a phone number';
  }
  // Regular expression for validating a phone number
  final RegExp phoneRegExp = RegExp(r'^\+?[0-9]{10,15}$');
  if (!phoneRegExp.hasMatch(value)) {
    return 'Please enter a valid phone number';
  }
  return '';
}
