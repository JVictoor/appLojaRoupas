//


import 'package:apploja/models/products_manager.dart';
import 'package:apploja/pages/images_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProductsScreen extends StatelessWidget {
  static const router = '/editprodutct';

  //para adicionar uma imagem
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
              ImagesForm(manager.products),//onde esta o carrocel de imagens
             
             //botão para validar se a pessoa escolheu uma imagem ou não(precis do formKey) ele precisa selecionar uma imagem da galeria ou do celular mesmo
              RaisedButton(
                key: formKey,
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    print('válido!!!');//aparece no console
                  }
                },
                child: const Text('Salvar'),
              ),
            ],
          );
        }
      )
    );
  }
}
