///Define validators for a variety of Text Fields, returns
///`null` if the input is valid or the corresponding error message as a `String`
class FieldValidators {
  static String? validateName(String? input) {
    input!.trim();
    RegExp validRegistrationPattern = RegExp(r'^[a-zA-Z0-9 À-ÿ]+$');
    if (validRegistrationPattern.hasMatch(input) && input.length <= 20) {
      return null;
    } else {
      return 'Nome inválido';
    }
  }

  static String? validateNotEmpty(String? input) {
    if (input == null || input.isEmpty) {
      return 'Campo Obrigatório';
    }
    return null;
  }
}
