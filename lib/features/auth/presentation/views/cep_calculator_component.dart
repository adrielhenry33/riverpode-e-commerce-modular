import 'package:arq_app/features/auth/domain/repository/cep_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CepCalculatorComponent extends ConsumerStatefulWidget {
  const CepCalculatorComponent({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _CepCalculatorComponent();
  }
}

class _CepCalculatorComponent extends ConsumerState<CepCalculatorComponent> {
  late final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(isLoadingCep);
    final endereco = ref.watch(enderecoProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                height: 50,

                child: TextFormField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Digite seu CEP',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.deepOrangeAccent,
                        width: 2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),

            MaterialButton(
              onPressed: () async {
                final cepDigitado = controller.text.trim().replaceAll(
                  RegExp(r'[^0-9]'),
                  '',
                );

                if (cepDigitado.length == 8) {
                  ref.read(isLoadingCep.notifier).state = true;
                  ref.read(enderecoProvider.notifier).state = null;
                  try {
                    final repository = ref.read(cepRepositoryProvider);
                    ref.read(enderecoProvider.notifier).state = await repository
                        .getAdress(cepDigitado);
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Erro ao buscar seu cep $e'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                  } finally {
                    ref.read(isLoadingCep.notifier).state = false;
                  }
                } else {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Cep Invalido, tente novamente!'),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }
                }
              },
              color: Colors.deepOrangeAccent,
              height: 48,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: isLoading
                  ? CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 1.0,
                    )
                  : Text(
                      'Calcular',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ],
        ),
        SizedBox(height: 15),

        if (endereco != null)
          Container(
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.deepOrangeAccent,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "Endereço Encontrado:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Divider(),
                Text(endereco.logradouro),
                Text(
                  '${endereco.bairro} - ${endereco.localidade}/${endereco.uf}',
                ),
                Text(
                  'CEP: ${endereco.cep}',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                Text(
                  'Entrega até sexta-feira',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
