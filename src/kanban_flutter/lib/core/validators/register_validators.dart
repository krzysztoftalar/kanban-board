String userNameValidator(String name) {
  if (name.isEmpty) {
    return "The field is required";
  } else if (name.length > 100) {
    return "Name title can't be over 100 characters.";
  }
  return null;
}

String registerPasswordValidator(String password) {
  final hasNumber = new RegExp(r"[0-9]+");
  final hasUpperChar = new RegExp(r"[A-Z]+");
  final hasLowerChar = new RegExp(r"[a-z]+");
  final hasMinChars = new RegExp(r".{6,}");
  final hasSymbols = new RegExp(r"[!@#$%^&*()_+=\[{\]};:<>|./?,-]");

  if (password.isEmpty) {
    return "The field is required";
  } else if (!hasLowerChar.hasMatch(password)) {
    return "Password should contain at least one lower case letter.";
  } else if (!hasUpperChar.hasMatch(password)) {
    return "Password should contain at least one upper case letter.";
  } else if (!hasMinChars.hasMatch(password)) {
    return "Password should not be lesser than 6 characters.";
  } else if (!hasNumber.hasMatch(password)) {
    return "Password should contain at least one numeric value.";
  } else if (!hasSymbols.hasMatch(password)) {
    return "Password should contain at least one special case character.";
  }
  return null;
}

String confirmPasswordValidator(String confirmPassword, String password) {
  if (confirmPassword.isEmpty) {
    return "The field is required";
  } else if (confirmPassword != password) {
    return "Passwords do not match";
  }
  return null;
}
