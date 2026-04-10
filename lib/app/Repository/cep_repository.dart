import 'package:arq_app/app/Services/resilient_client_adapter.dart';
import 'package:arq_app/app/models/cep_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CepRepository {
  final ClientHttpServiceImplementation _http;

  CepRepository({required ClientHttpServiceImplementation http}) : _http = http;

  Future<CepModel> getAdress(String cep) async {
    try {
      final json = await _http.get('https://viacep.com.br/ws/$cep/json/');
      return CepModel(
        bairro: json['bairro'],
        cep: json['cep'],
        logradouro: json['logradouro'],
        complemento: json['complemento'],
        localidade: json['localidade'],
        uf: json['uf'],
        estado: json['estado'],
      );
    } on Exception catch (e) {
      throw Exception('$e');
    }
  }
}

final cepRepositoryProvider = Provider<CepRepository>((ref) {
  return CepRepository(http: ClientHttpServiceImplementation());
});

final enderecoProvider = StateProvider<CepModel?>((ref) => null);
final isLoadingCep = StateProvider<bool>((ref) => false);
