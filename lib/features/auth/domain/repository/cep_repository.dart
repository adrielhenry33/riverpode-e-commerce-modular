import 'package:arq_app/app/interfaces/client_http_interface.dart';
import 'package:arq_app/features/auth/data/models/cep_model.dart';
import 'package:arq_app/features/products/presentation/providers/product_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CepRepository {
  final ClientHttpInterface _http;

  CepRepository({required ClientHttpInterface http}) : _http = http;

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
  final http = ref.watch(clientHttpProvider);
  return CepRepository(http: http);
});

final enderecoProvider = StateProvider<CepModel?>((ref) => null);
final isLoadingCep = StateProvider<bool>((ref) => false);
