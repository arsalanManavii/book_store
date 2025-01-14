class Utils {
  static String validation(String name, String description, int price) {
    String result = '';
    if (name.isEmpty || description.isEmpty || price == -1) {
      result = 'Fill Out All Inputs';
    }
    if (price > 10000000) {
      result = 'Enter a valid Number between 0 and 10,000,000';
    }
    return result;
  }
}
