import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:test_curso/estagiario.dart';

void main() {
  late Estagiario estagiario;

  setUpAll(() {
    print('*** Passou no setUpAll ***');
  });

  setUp(() {
    print('*** Passou no setUp ***');

    estagiario = Estagiario(
      nome: 'Wilson',
      horasExtras: 9,
      notaCurso: 6,
      qtdeAtividadesEntreges: 10,
    );
  });

  tearDown(() {
    print('*** Passou no tearDown ***');
  });

  tearDownAll(() {
    print('*** Passou no tearDownAll ***');
  });

  test(
      'Se a quantidade de horas trabalhadas for maior ou igual a 8 deve ser true',
      () {
    expect(estagiario.podeFolgar, true);
  }, skip: 'A função não está pronta');

  test('Verifica se propriedade nome é válida', () {
    expect(
      estagiario.nome,
      allOf([isNotNull, isA<String>(), equals('Wilson')]),
    );
  });

  group('Grupo de teste do curso', () {
    test('Se a nota for maior ou igual a 6 deve retornar true', () {
      expect(estagiario.passouNoCurso, true);
    });

    test(
        'Se a quantidade de atividades entregues for igual a 10 deve retornar true',
        () {
      expect(estagiario.entregouTodasAsAtividades, true);
    }, tags: 'web');
  });

  test('.parse() fails on invalid input', () {
    expect(() => int.parse('X'), throwsFormatException);
  });
}
