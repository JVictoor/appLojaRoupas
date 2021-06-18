//PAGINA PARA EDITAR OS PRODUTOS 

import 'package:apploja/models/products_manager.dart';
import 'package:apploja/pages/images_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProductsScreen extends StatelessWidget {
  static const router = '/editprodutct';

  //para adicionar uma imagem
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
      final primaryColor = Theme.of(context).primaryColor; //quando que descobrir para o que usou volta com ele

    return Scaffold(
        appBar: AppBar(
          title: const Text('Editar Roupa'),
          centerTitle: true,
        ),
        body: Consumer<ProductsManager>(builder: (_, manager, __) {
          child:
          return Form(
              key: formKey,
              child: ListView(
                children: <Widget>[
                  ImagesForm(
                      manager.products), //onde esta o carrocel de imagens


                  //dados para alteração
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        TextFormField(
                          initialValue: manager.products.color, //busca para alterar o modelo
                          decoration: const InputDecoration(
                            hintText: 'PRAQUESERVEISSO?',
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                          validator: (color) {
                            if ( color.length < 1)
                              return 'preencha o valor correto correto'; //validador de tamanho de alteração
                            return null;
                          },
                          //aqui manda salvar a alteração
                          onSaved: (color) => manager.products.color = color,
                        ),

                       
                       //esse trecho serve para colocar uma descrição entre os dados
                        /* Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        'Modelo',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ), */

                        TextFormField(
                          initialValue: manager.products.model,
                          style: const TextStyle(fontSize: 16),
                          decoration: const InputDecoration(
                              hintText: 'Modelo', border: InputBorder.none),
                          maxLines: null,
                          validator: (model) {
                            if (model.length < 1)
                              return 'Preencha o modelo correto';
                            return null;
                          },
                          //aqui manda salvar a alteração
                          onSaved: (model) => manager.products.model = model,
                        ),

                         TextFormField(
                          initialValue: manager.products.size,
                          style: const TextStyle(fontSize: 16),
                          decoration: const InputDecoration(
                              hintText: 'Tamanho', border: InputBorder.none),
                          maxLines: null,
                          validator: (size) {
                            if (size.length < 1)
                              return 'Preencha o tamanho correto';
                            return null;
                          },
                          //aqui manda salvar a alteração
                          onSaved: (size) => manager.products.size = size,
                        ),

                        TextFormField(
                          initialValue: manager.products.price,
                          style: const TextStyle(fontSize: 16),
                          decoration: const InputDecoration(
                              hintText: 'Preço', border: InputBorder.none),
                          maxLines: null,
                          validator: (price) {
                            if (price.length < 1)
                              return 'Preencha o preço correto';
                            return null;
                          },
                          //aqui manda salvar a alteração
                          onSaved: (price) => manager.products.price = price,
                        ),


                        RaisedButton(
                          onPressed: () {
                            if (formKey.currentState.validate()) {
                              //pega o estado corrente - o que se encontra- e salva os dados
                              formKey.currentState.save();
                              manager.products.save(); // aqui que o cole acontece de salvar quando clica no botão de salvar
                              
                            }                           
                          },

                          textColor: Colors.white,
                          color: primaryColor,
                          disabledColor: primaryColor.withAlpha(100),
                          child: const Text('Salvar'),
                          
                        ),

                      ],
                    ),
                  ),

                  //botão para validar se a pessoa escolheu uma imagem ou não(precis do formKey) ele precisa selecionar uma imagem da galeria ou do celular mesmo
                ],
              ));
        }));
  }
}
