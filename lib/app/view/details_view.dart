import 'package:arq_app/components/review_component.dart';
import 'package:arq_app/features/auth/presentation/views/cep_calculator_component.dart';
import 'package:arq_app/features/cart/data/models/cart_model.dart';
import 'package:arq_app/features/cart/presentation/viewmodel/cart_product_viewmodel.dart';
import 'package:arq_app/features/products/domain/entities/product_entity.dart';
import 'package:arq_app/features/products/presentation/view/pop_up_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailsView extends ConsumerStatefulWidget {
  final ProductEntity produto;

  const DetailsView({super.key, required this.produto});

  @override
  ConsumerState<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends ConsumerState<DetailsView> {
  final pagCtrl = PageController();
  final controller = TextEditingController();
  int currentIndex = 0;

  @override
  void dispose() {
    pagCtrl.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final carrinhoProvider = ref.watch(cartProvider);

    final bool isOnCart = carrinhoProvider.any(
      (element) => element.produto.id == widget.produto.id,
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: Text('Detalhes do Produto'),
        centerTitle: true,
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Modular.to.pushNamed('/carrinho');
                },
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.deepOrangeAccent,
                  size: 30,
                ),
              ),
              if (carrinhoProvider.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: Center(
                      child: Text(
                        '${carrinhoProvider.length}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              const SizedBox(width: 10),
            ],
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 20, right: 15, left: 15, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.produto.title,
                    style: TextStyle(fontSize: 20, fontFamily: 'MontSerrat'),
                  ),

                  PopUpComponent(produto: widget.produto, showAllIcons: false),
                ],
              ),

              SizedBox(
                height: 350,
                child: PageView(
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  controller: pagCtrl,
                  children: widget.produto.images.map((urlImage) {
                    return Image.network(
                      urlImage,
                      fit: BoxFit.fill,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Center(child: Icon(Icons.error));
                      },
                    );
                  }).toList(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(widget.produto.images.length, (index) {
                  return AnimatedContainer(
                    duration: Duration(microseconds: 300),
                    curve: Curves.easeOut,
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    height: 8,
                    width: currentIndex == index ? 25 : 8,
                    decoration: BoxDecoration(
                      color: currentIndex == index
                          ? Colors.deepOrangeAccent
                          : Colors.grey[500],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'De',
                    style: TextStyle(fontFamily: 'MontSerrat', fontSize: 20),
                  ),

                  SizedBox(width: 8),
                  Text(
                    'R\$${widget.produto.price} ',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      decoration: TextDecoration.lineThrough,
                      decorationThickness: 2,
                    ),
                  ),
                  Text(
                    'por apenas',
                    style: TextStyle(fontFamily: 'MontSerrat', fontSize: 20),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.label_important, color: Colors.red),
                  Text(
                    ' R\$${((widget.produto.price - (widget.produto.price * widget.produto.discountPercentage) / 100)).toStringAsFixed(2)}',
                    style: TextStyle(
                      fontFamily: 'MontSerrat',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 60,

                child: MaterialButton(
                  onPressed: () {},
                  color: Colors.deepOrangeAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(12),
                  ),
                  child: Text(
                    'Comprar agora',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                height: 60,

                child: MaterialButton(
                  minWidth: double.infinity,
                  onPressed: () {
                    final copy = CartProductModel(
                      produto: widget.produto,
                      quantidade: 1,
                    );

                    ref.read(cartProvider.notifier).addProduct(copy);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Produto adicionado ao carrinho'),
                        duration: Duration(seconds: 1),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(12),
                    side: BorderSide(color: Colors.deepOrange),
                  ),
                  child: Text(
                    'Adicionar ao carrinho',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Calcule Frete e Prazo',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'MontSerrat',
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10),

              CepCalculatorComponent(),

              SizedBox(height: 15),

              Text(
                'Descrição do Produto',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'MontSerrat',
                ),
                textAlign: TextAlign.start,
              ),

              SizedBox(height: 15),

              Text(widget.produto.description),

              SizedBox(height: 15),

              Text(
                'Avaliações',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'MontSerrat',
                ),
                textAlign: TextAlign.start,
              ),

              SizedBox(height: 15),
              ProductReviewsComponent(),
            ],
          ),
        ),
      ),
    );
  }
}
