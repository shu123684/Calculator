import 'package:calculator/btn.dart';
// Tried But Failed due to "SetState"
// Completely Independent
String conversion(String text) {
  text = text.replaceAll("×", "*");
  text = text.replaceAll("÷", "/");
  return text;
}
String removeTrailingZeros(double n) {
  return double.parse(
    n.toStringAsFixed(
      n.truncateToDouble() == n ? 0 : n.toString().split('.')[1].length,
    ),
  ).toString();
}

// Subtly Dependent 
// 1. 
bool dotCheck(String text, int cursorPos) {
  if (!text.contains(Btn.dot)) return false;
  int offset = 1;
  if(cursorPos == 0) offset = 0;
  int j = cursorPos-offset;
  int i = cursorPos-offset;

  // right check
  bool rightcheck = false;
  for (
  i;
  i < text.length &&
      (text[i] != Btn.add &&
          text[i] != Btn.subtract &&
          text[i] != Btn.multiply &&
          text[i] != Btn.divide
      );
  i++
  ) {
    if (text[i] == Btn.dot) {
      rightcheck = true;
      break;
    }
  }

  //Left check
  bool leftcheck = false;
  for (
  j;
  j >= 0 &&
      (text[j] != Btn.add &&
          text[j] != Btn.subtract &&
          text[j] != Btn.multiply &&
          text[j] != Btn.divide);
  j--
  ) {
    if (text[j] == Btn.dot) {
      leftcheck = true;
      break;
    }
  }
  if (leftcheck || rightcheck) {
    return true;
  } else {
    return false;
  }
}
