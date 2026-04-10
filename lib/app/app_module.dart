import 'package:arq_app/features/cart/presentation/view/carrinho_view.dart';
import 'package:arq_app/app/view/details_view.dart';
import 'package:arq_app/features/home/views/home_view.dart';
import 'package:arq_app/features/auth/presentation/views/login_view.dart';
import 'package:arq_app/features/products/domain/entities/product_entity.dart';
import 'package:arq_app/features/products/presentation/view/products_list_view.dart';
import 'package:arq_app/features/auth/presentation/views/profile_view.dart';
import 'package:arq_app/app/view/recover_view.dart';

import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) {
        return HomeView();
      },
    );
    r.child('/register', child: (context) => RecoverView());
    r.child('/recover', child: (context) => RecoverView());
    r.child(
      '/produtos',
      child: (context) {
        final args = r.args.data as Map<String, dynamic>;
        return ProductsListView(
          nomeCategoria: args['categoria'],
          titulo: args['titulo'],
        );
      },
    );
    r.child(
      '/details',
      child: (context) {
        final args = r.args.data as ProductEntity;
        return DetailsView(produto: args);
      },
    );
    r.child(
      '/carrinho',
      child: (context) {
        return CartView();
      },
    );
    r.child('/profile', child: (context) => ProfileView());
    r.child('/login', child: (context) => LoginView());
  }
}
