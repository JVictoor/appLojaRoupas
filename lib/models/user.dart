//tudo o que se refere ao cadastro de algo tem que vir aqui
/* classe que interage com os usuarios */

import 'package:cloud_firestore/cloud_firestore.dart';
//json
class User {
  User({this.id, this.email, this.password, this.name, this.cpf});
  //Firebase trabalha com arquivo em txt (JSON), Esta pegando os dados atribuindo o que eles são e colocando no documento
  User.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    name = document.data['name'] as String;
    cpf = document.data['cpf'] as String;
    email = document.data['email'] as String;
    password = document.data['password'] as String;
  }

  String id;
  String email;
  String password;
  String name;
  String cpf;
  //
  //método para salvar todos os dados no banco Firestore DataBase
  ////nome da coleção tem que ser o mesmo que foi colocado lá nahora de criar a coleção
  Future<void> saveData() async {
    await Firestore.instance.collection('users').document(id).setData(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'cpf': cpf,
      'email': email,
    };
  }
}
