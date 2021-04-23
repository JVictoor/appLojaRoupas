/* classe gerenciadora dos usuarios, verifica quais users estão cadastrados */
//aqui éa continuação dos dados para cadastro, onde esta ligando os dados com o banco
import 'package:apploja/helpers/firebase_errors.dart';
import 'package:apploja/models/products.dart';
import 'package:apploja/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class ProductsManager {
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
}

