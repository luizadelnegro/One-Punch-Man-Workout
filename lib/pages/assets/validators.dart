

class Validators {

  static String title(String input) {
    if(input.isEmpty) {
      return "Preencha algo";
    }
    else if(input.length > 30) {
      return "Não deve ultrapassar 30 caracteres";
    }
  }
}