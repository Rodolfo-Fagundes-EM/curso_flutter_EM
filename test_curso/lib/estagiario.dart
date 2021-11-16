import 'dart:convert';

class Estagiario {
  String nome;
  double horasExtras;
  double notaCurso;
  int qtdeAtividadesEntreges;

  Estagiario({
    required this.nome,
    required this.horasExtras,
    required this.notaCurso,
    required this.qtdeAtividadesEntreges,
  });

  bool get podeFolgar => horasExtras >= 8;

  bool get passouNoCurso => notaCurso >= 6;

  bool get entregouTodasAsAtividades => qtdeAtividadesEntreges == 10;

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'horasExtras': horasExtras,
      'notaCurso': notaCurso,
      'qtdeAtividadesEntreges': qtdeAtividadesEntreges,
    };
  }

  factory Estagiario.fromMap(Map<String, dynamic> map) {
    return Estagiario(
      nome: map['nome'],
      horasExtras: map['horasExtras'] * 1.0,
      notaCurso: map['notaCurso'] * 1.0,
      qtdeAtividadesEntreges: map['qtdeAtividadesEntreges'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Estagiario.fromJson(String source) =>
      Estagiario.fromMap(json.decode(source));
}
