

class Validators {

  static String title(String input) {
    if(input.isEmpty) {
      return "Type a name!";
    }
    else if(input.length > 30) {
      return "It must not contain more than 30 characters";
    }
  }
}