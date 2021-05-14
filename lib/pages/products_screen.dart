//chama para poder listar os livros
import 'package:apploja/models/products_manager.dart';
import 'package:apploja/pages/products_list.dart';
import 'package:provider/provider.dart';//consumer
import 'package:apploja/pages/custom_drawer.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  
  static const router='/products';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text('Lista de Roupas'),
        centerTitle: true,
      ),
      body: Consumer<ProductsManager>(//consumer é importação do provider
        builder: (_, productManager, __){
          return ListView.builder(
            padding: const EdgeInsets.all(4),
            //verifica o tamanho do nosso arrey
            itemCount: productManager.allProducts.length,
            itemBuilder: (_, index){
              return ProductsList(productManager.allProducts[index]);
            }
          );
        },
      ),
    );
  }
}