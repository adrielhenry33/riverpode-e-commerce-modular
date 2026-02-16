import 'package:arq_app/app/components/custom_bottom_app_bar_component.dart';
import 'package:arq_app/app/components/custom_card_component.dart';
import 'package:arq_app/app/viewmodels/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/cupertino.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeViewModel viewmodel = Modular.get<HomeViewModel>();
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final height = size.height * 0.28;
    final double sizeUp = 100.0;
    final color = ColorScheme.of(context);

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: CustomBottomAppBar(),
        body: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              height: height,
              child: Container(
                height: 200,
                decoration: BoxDecoration(color: Colors.deepOrangeAccent),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: 30,
                      vertical: 55,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              'F',
                              style: TextStyle(
                                color: Colors.deepOrangeAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'FakeStore',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'MontSerrat',
                            fontSize: 35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              top: height - sizeUp,
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: color.surfaceBright,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: 20,
                      vertical: 30,
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _controller,

                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],

                            hint: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                'Search',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Roboto',
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Icon(
                                Icons.search,
                                color: Colors.deepPurpleAccent,
                                size: 30,
                              ),
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.deepPurpleAccent,
                                size: 30,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        SizedBox(height: 15),

                        GridView.count(
                          childAspectRatio: 0.75,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          primary: false,
                          crossAxisCount: 2,
                          padding: EdgeInsets.only(top: 10, bottom: 15),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          children: [
                            CustomCardComponent(
                              urlImagemFundo: 'images/bg_eletronicos_suave.png',
                              urlProduto: 'images/eletronicos_.png',
                              categoria: 'Eletônicos',
                              fraseEfeito: 'Poder e Modernidade',
                              height: 180,
                              width: 0,
                              bottom: -5,
                              left: 2,
                              right: 2,
                              nomeCategoria: 'eletronicos',
                              titulo: 'Eletrônicos',
                            ),
                            CustomCardComponent(
                              urlImagemFundo: 'images/bg_variedades_suave.png',
                              urlProduto: 'images/variedades_.png',
                              categoria: 'Variedades',
                              fraseEfeito: 'Um pouco de Tudo',
                              height: 180,
                              width: 10,
                              bottom: 0,
                              left: 2,
                              right: 2,
                              nomeCategoria: 'groceries',
                              titulo: 'Variedades',
                            ),

                            CustomCardComponent(
                              urlImagemFundo: 'images/bg_moveis_suave.png',
                              urlProduto: 'images/moveis_.png',
                              categoria: 'Móveis',
                              fraseEfeito: 'Padrão e Estética',
                              height: 150,
                              width: 0,
                              bottom: 20,
                              left: 1,
                              right: -12,
                              nomeCategoria: 'furniture',
                              titulo: 'Móveis',
                            ),
                            CustomCardComponent(
                              urlImagemFundo: 'images/bg_padrao_suave.png',
                              urlProduto: 'images/beleza_.png',
                              categoria: 'Beleza',
                              fraseEfeito: 'Cuidados Diários',
                              height: 200,
                              width: 0,
                              bottom: -10,
                              left: 1,
                              right: -12,
                              nomeCategoria: 'beauty',
                              titulo: 'Beleza',
                            ),
                          ],
                        ),

                        Container(
                          width: double.infinity,
                          height: 150,

                          decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            image: DecorationImage(
                              image: AssetImage('images/purple_background.png'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 20,
                              bottom: 20,
                              left: 40,
                              right: 10,
                            ),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'O que gostaria',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                    ),
                                    Text(
                                      'de comprar?',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.clip,
                                      ),
                                      maxLines: 1,
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                                SizedBox(width: 40),
                                MaterialButton(
                                  onPressed: () {},
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadiusGeometry.circular(
                                      12,
                                    ),
                                  ),
                                  color: Colors.deepOrangeAccent,
                                  child: Text(
                                    'Comece agora!',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
