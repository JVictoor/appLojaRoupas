// tela base 
//widget - controlador visual

import 'package:apploja/pages/custom_drawer.dart';
import 'package:apploja/pages/loginscreen.dart';
import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {

  //PageController -> controlador de páginas acessadas
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold (
          
         //LoginScreen(),//tela de login
          // //acessando o arquivo do menu lateral
          drawer: CustomDrawer(),//onde esta o meu menu
          appBar : AppBar (
          title:  const Text("MENUZINHO ^-^"),
          ),
        ),
      ],
    );
  }
}