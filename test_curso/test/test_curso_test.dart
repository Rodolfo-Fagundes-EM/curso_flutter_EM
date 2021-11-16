import 'package:test_curso/test_curso.dart';
import 'package:test/test.dart';

void main() {
  test('calculate', () {
    expect(calculate(), equals(42));
  });

  test('Calcula IMC deve retornar 26.23', () {
    expect(calculateIMC(85, 1.80), equals(26.23));
  });
}
