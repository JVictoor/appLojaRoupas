//aqui é um gerenciador de paginas

import 'package:flutter/cupertino.dart';

class PageManager {
  
  //recebe a pagina controladora, a pagina eu escolho
  PageManager(this._pageController);
  
  //cupertino - precisa dessa importação a cupertino
  PageController _pageController;

  int page = 0;

  void setPage(int value){
    if(value == page) return;//se o valor recebido for igual ao da pagina ele joga na pagina que escolhemos
    page = value;//esta vendo se a pagina que estamos escolhemos é igual a que estamos ou não, se for igual a que estamos ele retorna NULL se for diferente ele pega o novo valor e retorna para a pagina que nós queremos
    _pageController.jumpToPage(value);//jumpToPage metodo que joga a gente na pagina que esoclhemos
  }
} 