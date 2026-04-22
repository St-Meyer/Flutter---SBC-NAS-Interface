class ValueCalculation {
  double convertBytes(int input) {
    double result = input.toDouble();
    int counter = 0;
    while (result > 999) {
      result = result / 1024;
      counter++;
    }
    return result;
  }
}
