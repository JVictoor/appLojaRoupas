//chama para poder listar os livros
import 'package:apploja/models/products_manager.dart';
import 'package:apploja/pages/products_list.dart';
import 'package:provider/provider.dart';//consumer
import 'package:apploja/pages/custom_drawer.dart';
import 'package:apploja/pages/search_dialog.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  
  static const router='/products'; // rota para chamar quando clicar - complemento dela esta na main.dart

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
       // title: const Text('Lista de Roupas'),
       //filtroooooooooooooooooooooo
       title: Consumer<ProductsManager>(
          builder: (_, productManager, __){
            if(productManager.search.isEmpty){
              return const Text('Produtos');
            } else {
              return LayoutBuilder(
                builder: (_, constraints){
                  return GestureDetector(
                    onTap: () async {
                      final search = await showDialog<String>(context: context,
                          builder: (_) => SearchDialog(productManager.search));
                      if(search != null){
                        productManager.search = search;
                      }
                    },
                    child: Container(
                      width: constraints.biggest.width,
                      child: Text(
                        productManager.search,
                        textAlign: TextAlign.center,
                      )
                    ),
                  );
                },
              );
            }
          },
        ),
        centerTitle: true,
          
          //icone de buscapara realziar o filtro (SearchDialog)
          actions: <Widget>[
 
            Consumer<ProductsManager>(
             builder: (_, productManager, __){
              if(productManager.search.isEmpty){
                return IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () async {
                    final search = await showDialog<String>(context: context,
                        builder: (_) => SearchDialog(productManager.search));
                    if(search != null){
                      productManager.search = search;
                    }
                  },
                );
              } else {
                return IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () async {
                    productManager.search = '';
                  },
                );
              }
             }
            )
          ]
      ),
      body: Consumer<ProductsManager>(//consumer é importação do provider
        builder: (_, productManager, __){

          //filtrooooooooooooooooooooooooooooooo
            final filteredProducts = productManager.filteredProducts;
          
          return ListView.builder(
            padding: const EdgeInsets.all(4),
            //verifica o tamanho do nosso arrey do FILTROOOOOOOOO
            itemCount: filteredProducts.length,
            itemBuilder: (_, index){
              
              //filtro de novooooooooooooooooooo
               return ProductsList(filteredProducts[index]);
            }
          );
        },
      ),
    );

    //lib/screens/product/product_screen.dart  link2 veremos o que da sem aquela parte
  }
}