/* classe gerenciadora dos usuarios, verifica quais users estão cadastrados */
//aqui éa continuação dos dados para cadastro, onde esta ligando os dados com o banco
import 'package:apploja/helpers/firebase_errors.dart';
import 'package:apploja/models/products.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

//ChangeNotifier-> chama as notificações

class ProductsManager extends ChangeNotifier {
  final Firestore firestore = Firestore.instance;

  Future<void> registro(
      {Products products, Function onFail, Function onSuccess}) async {
    try {
      await products.saveData();

      onSuccess();
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }
  }



  ProductsManager() {
    //acessa o método private da classe para ler todo os produtos cadastrados
    loadAllProducts();//quando clica em produtos no app, chama esse metodo para abrir todos os livros
  }
  //instancia o firebase firestore
  final Firestore firesore = Firestore.instance;

  List<Products> allProducts = [];

  //buscador do filtro
  String _search = '';

  String get search => _search;
  set search(String value){
    _search = value;
    notifyListeners();
  }

  List<Products> get filteredProducts {
    final List<Products> filteredProducts = [];

    if(search.isEmpty){
      filteredProducts.addAll(allProducts);
    } else {
      filteredProducts.addAll(
        allProducts.where(
          (p) => p.color.toLowerCase().contains(search.toLowerCase())
        )
      );
    }

    return filteredProducts;
  }


  Future<void> loadAllProducts() async{

    final QuerySnapshot snapProducts = 
      await firesore.collection('products').getDocuments();
      //collection('products') precisa ser o memso nome da coleção criada no firestore

      allProducts = snapProducts.documents.map((d) => Products.fromDocument(d)).toList();
    
      notifyListeners();

  }

}










/*   
só grava no banco sem imagens

Future<void> registro(
      {Products products, Function onFail, Function onSuccess}) async {
    try {
      await products.saveData();

      onSuccess();
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }
  } */