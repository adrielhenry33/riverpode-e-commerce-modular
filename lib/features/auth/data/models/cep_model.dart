class CepModel {
  final String cep;
  final String logradouro;
  final String complemento;
  final String bairro;
  final String localidade;
  final String uf;
  final String estado;

  CepModel({
    required this.bairro,
    required this.cep,
    required this.logradouro,
    required this.complemento,
    required this.localidade,
    required this.uf,
    required this.estado,
  });

  factory CepModel.fromJson(Map<String, dynamic> json) {
    return CepModel(
      bairro: json['bairro'],
      cep: json['cep'],
      logradouro: json['logradouro'],
      complemento: json['complemento'],
      localidade: json['localidade'],
      uf: json['uf'],
      estado: json['estado'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bairro': bairro,
      'cep': cep,
      'logradouro': logradouro,
      'localidade': localidade,
      'complemento':complemento,
      'uf': uf,
      'estado': estado,
    };
  }
}
