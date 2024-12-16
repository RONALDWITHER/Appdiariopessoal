class Anotacoes {
  Anotacoes(
      {required this.titulo_da_anotacao,
      required this.dataHorario,
      required this.texto_da_anotacao,
      required this.id,
      this.urlImagem});

  String id;
  String titulo_da_anotacao;
  DateTime dataHorario;
  String texto_da_anotacao;
  String? urlImagem;

  Anotacoes.fromMap(Map<String, dynamic> map)
      : id = map['id'] ?? '', // Define um valor padrão
        titulo_da_anotacao = map['titulo_da_anotacao'] ?? '',
        texto_da_anotacao = map['texto_da_anotacao'] ?? '',
        dataHorario = map['DataHorario'] != null
            ? DateTime.parse(map['DataHorario'])
            : DateTime.now(),
        urlImagem = map['urlImagem'];
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo_da_anotacao': titulo_da_anotacao,
      'texto_da_anotacao': texto_da_anotacao,
      'DataHorario': dataHorario.toIso8601String(),
      'urlImagem': urlImagem
    };
  }
}
