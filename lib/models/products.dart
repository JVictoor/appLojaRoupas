//tudo o que se refere ao cadastro de algo tem que vir aqui
/* classe que interage com os usuarios */

import 'package:cloud_firestore/cloud_firestore.dart';

class Products {
  Products({ this.id, this.color, this.model, this.price, this.size, });
  //Firebase trabalha com arquivo em txt (JSON), Esta pegando os dados atribuindo o que eles são e colocando no documento
  Products.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    color = document.data['color'] as String;
    model = document.data['model'] as String;
    size = document.data['size'] as String;
    price = document.data['price'] as String;
   
  }

  String id;
  String color;
  String model;
  String size;
  String price;

  //
  //método para salvar todos os dados no banco Firestore DataBase
  ////nome da coleção tem que ser o mesmo que foi colocado lá nahora de criar a coleção
  Future<void> saveData() async {
    await Firestore.instance.collection('products').document(id).setData(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'color': color,
      'model': model,
      'size': size,
      'price':price,
    };
  }
}
