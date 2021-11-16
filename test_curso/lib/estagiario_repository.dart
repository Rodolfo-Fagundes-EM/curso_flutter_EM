import 'dart:convert';

import 'package:http/http.dart';
import 'package:test_curso/estagiario.dart';

class EstagiarioRepository {
  final Client client;

  EstagiarioRepository(this.client);

  Future<List<Estagiario>> getEstagiario() async {
    Response response = await client.get(Uri.parse(
        'https://fc8151cc-9bd8-459b-91a8-d431a193afd5.mock.pstmn.io/v1/estagiarios'));

    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body) as List;
      return jsonList.map((e) => Estagiario.fromMap(e)).toList();
    } else {
      throw Exception(
          'Erro na consulta da API estagiarios, statusCode = ${response.statusCode}');
    }
  }
}
