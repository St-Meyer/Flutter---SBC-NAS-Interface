import 'byte_container.dart';

class ValueCalculation {
  ByteContainer convertBytes(int input) {
    double result = input.toDouble();
    int counter = 0;
    String byteName = "";
    while (result > 999) {
      result = result / 1024;
      counter++;
    }
    switch (counter) {
      case 0:
        byteName = "Bytes";
        break;
      case 1:
        byteName = "KiB";
        break;
      case 2:
        byteName = "MiB";
        break;
      case 3:
        byteName = "GiB";
        break;
      case 4:
        byteName = "TiB";
        break;
      case 5:
        byteName = "PiB";
        break;
      default:
        byteName = "unknown";
        break;
    }

    var container = ByteContainer(result, byteName);
    return container;
  }
}
