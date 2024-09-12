class Validators {
  //validate url
  static String? validateUrl(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a URL';
    }
    if (!Uri.parse(value).isAbsolute) {
      return 'Please enter a valid URL';
    }

    return null;
  }
}
