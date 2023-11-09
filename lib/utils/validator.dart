
const int minChars = 2;
const int maxChars = 20;
const String errorUserEmpty = 'Insira um usuário válido';
const String errorPasswordEmpty = 'Insira uma senha válida';
const String errorPasswordTooShort = 'A senha precisa ter mais que $minChars caracteres';
const String errorPasswordTooLong = 'A senha precisa ter menos que $maxChars caracteres';
const String errorPasswordSpecialChars = 'A senha não pode conter caracteres especiais';
const String specialCharactersPattern = r'[^a-zA-Z0-9]';

class LoginValidator {

  static String? validateLogin(String? value) {
    if (isValueEmpty(value)) {
      return errorUserEmpty;
    }
    return null;
  }

  static String? validatePassword(String? value) {
    final RegExp specialCharactersRegExp = RegExp(specialCharactersPattern);

    if (isValueEmpty(value)) {
      return errorPasswordEmpty;
    } else if (value!.length < minChars) {
      return errorPasswordTooShort;
    } else if (value.length > maxChars) {
      return errorPasswordTooLong;
    } else if (specialCharactersRegExp.hasMatch(value)) {
      return errorPasswordSpecialChars;
    }

    return null;
  }

  static bool isValueEmpty(String? value) {
    if(value == null || value.isEmpty){
      return true;
    }
    return false;
  }

}
