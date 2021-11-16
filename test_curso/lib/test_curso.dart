import 'dart:math' as math;

int calculate() {
  return 6 * 7;
}

double calculateIMC(double peso, double altura) {
  double result = peso / math.pow(altura, 2);
  result = result * 100;
  return result.roundToDouble() / 100;
}
