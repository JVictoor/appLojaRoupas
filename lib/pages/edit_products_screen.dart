//


import 'package:apploja/models/products_manager.dart';
import 'package:apploja/pages/images_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProductsScreen extends StatelessWidget {
  static const router = '/editprodutct';

/*   const EditProductsScreen(this.products);

  final Products products; */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Editar Roupa'),
          centerTitle: true,
        ),
        body: Consumer<ProductsManager>(builder: (_, manager, __) {
          return ListView(
            children: <Widget>[
              ImagesForm(manager.products),
            ],
          );
        }
      )
    );
  }
}
