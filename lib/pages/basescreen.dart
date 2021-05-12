// tela base
//widget - controlador visual

import 'package:apploja/models/page_manager.dart';
import 'package:apploja/models/products.dart';
import 'package:apploja/pages/cadastrar_products.dart';
import 'package:apploja/pages/custom_drawer.dart';
import 'package:apploja/pages/loginscreen.dart';
import 'package:apploja/pages/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {
  //PageController -> controlador de páginas acessadas
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      //estamos criando uma pagemaneger passando a page controller(que faz o caminho)
      //provider: é um provedor para saber qual a pagina que estamos acessando

      create: (_) => PageManager(pageController),
      //pageview mostra qual item vamos escolher
      child: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          Scaffold(
            //LoginScreen(),//tela de login
            // //acessando o arquivo do menu lateral
            drawer: CustomDrawer(), //onde esta o meu menu
           //barra de titulo do app
            appBar: AppBar(
              title: const Text("HOMEZINHO ^^ "),
            ),
          ),

          ProductsScreen(),//chama para poder listar os livros

        ],
      ),
    );
  }
}
