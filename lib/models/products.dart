//tudo o que se refere ao cadastro de algo tem que vir aqui, pois conecta com o banco
/* classe que interage com os usuarios */

import 'package:cloud_firestore/cloud_firestore.dart';

class Products {
  
  Products({ this.id, this.color, this.model, this.price, this.size, this.images}){
   
    //arrey para conjunto de imagens
    images = images ?? [];
  }
  
  //Firebase trabalha com arquivo em txt (JSON), Esta pegando os dados atribuindo o que eles são e colocando no documento
  //(DocumentSnapshot - faz as leituras dos dados no firebase, REALIZA A CONVERÇÃO DELES
  Products.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    color = document.data['color'] as String;
    model = document.data['model'] as String;
    size = document.data['size'] as String;
    price = document.data['price'] as String;

    //metodo de listar
    images = List<String>.from(document.data['images'] as List<dynamic>);
   
  }

  String id;
  String color;
  String model;
  String size;
  String price;
  List<String> images;

  //criando uma lista dinamica com as novas imagens
  List<dynamic> newImages;

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

//criar o metodo to-string para fazer a converção entre eles mesmo para salvar no banco
@override
  String toString() {
    return 'Product{id: $id, color: $color, model: $model, size: $size, price: $price, newImages: $newImages}';
  }

}
