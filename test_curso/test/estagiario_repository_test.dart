import 'package:http/http.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:test_curso/estagiario_repository.dart';

void main() {
  final Client client = Client();

  final repository = EstagiarioRepository(client);

  test('API deve retornar uma lista de estagiarios', () async {
    final list = await repository.getEstagiario();

    expect(list, isNotNull);
    expect(list.length, equals(3));
    expect(list.first.nome, equals('Daniel'));
  });
}
