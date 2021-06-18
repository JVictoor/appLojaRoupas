//tudo o que se refere ao cadastro de algo tem que vir aqui, pois conecta com o banco
/* classe que interage com os usuarios */

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class Products {
  Products(
      {this.id, this.color, this.model, this.price, this.size, this.images}) {
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

  //grava alteração do firebase das imagens
  final Firestore firestore = Firestore.instance;

  //aque é onde a magica do armazenamento da imagem acontece no firebase
  final FirebaseStorage storage = FirebaseStorage.instance;

  DocumentReference get firestoreRef => firestore.document(
      'produtcs/$id'); //refere qual o id do produto que vai alterar no banco(pagina de alteração)

  //vai na products.dart, verifica qual o id da imagem para poder ver qual a referencia que está sendo armazenado
  StorageReference get storageRef => storage.ref().child('products').child(id);

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
    await Firestore.instance
        .collection('products')
        .document(id)
        .setData(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'color': color,
      'model': model,
      'size': size,
      'price': price,
    };
  }

//criar o metodo to-string para fazer a converção entre eles mesmo para salvar no banco
  @override
  String toString() {
    return 'Product{id: $id, color: $color, model: $model, size: $size, price: $price, newImages: $newImages}';
  }

//Metodo que salva, mapeando dinamicamente os dados para salvar relacionado ao metodo editar
  Future<void> save() async {
    final Map<String, dynamic> data = {
      'color': color,
      'model': model,
      'size': size,
      'price': price,
    };

    // se o id for igual a nulo, ele vai criar um novo item na coleção no banco trabalha junto com o mapeamento
    if (id == null) {
      final doc = await firestore.collection('products').add(data);
      id = doc.documentID;
    } else {
      await firestoreRef.updateData(
          data); //se o id já existir ele vai dar o update, que vai realizar a alteração no banco
    }

    //esse array vai verificar qual é a imagem nova que esta relacionada com a que já existe para poder fazer o update
    final List<String> updateImages = [];

    for (final newImage in newImages) {
      //Se array de imagem contém uma nova imagem, da update adicionando uma nova imagem
      if (images.contains(newImage)) {
        updateImages.add(newImage as String);
      } else {
        //Uuid gera um valor qualquer de id
        final StorageUploadTask task =
            storageRef.child(Uuid().v1()).putFile(newImage as File);

        /*  File é .io
          e o Uuid() é do pubspec,yaml
       */
        //onComplete faz upload na imagem no firebase
        final StorageTaskSnapshot snapshot = await task.onComplete;
        final String url = await snapshot.ref.getDownloadURL()
            as String; //gerando uma url para a img
        //Gravando na url do arquivo
        updateImages.add(url);
      }
    }

    //Verifica se uma imagem não existe mais no array imagens
    for (final image in images) {
      if (!newImages.contains(image)) {
        try {
          final ref = await storage.getReferenceFromUrl(image);
          await ref.delete();
        } catch (e) {
          debugPrint('Falha ao deletar $image');
        }
      }
    }

    await firestoreRef.updateData({'images': updateImages});
  }
}
