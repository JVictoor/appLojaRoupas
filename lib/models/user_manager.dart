/* classe gerenciadora dos usuarios, verifica quais users estão cadastrados */
//aqui éa continuação dos dados para cadastro, onde esta ligando os dados com o banco
import 'dart:html';

import 'package:apploja/helpers/firebase_errors.dart';
import 'package:apploja/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';


//User user;
class UserManager extends ChangeNotifier {
 
  UserManager() {
  //acesasndo o metoro que verifica qual usuario esta logado
  //quando chama a user manager chama o metodo _loadCurrenteUser
    _loadCurrentUser(); //metodo que verifica o usuario corrente(que esta logado)
  }

  /* utiliza o Firebase Auth, instanciando ela, jogando em auth para pegar o metodo sigIn para verificar se o password é valido*/
  final FirebaseAuth auth =  FirebaseAuth.instance; //fazer a autenticação do e-mail e senha
  final Firestore firestore = Firestore.instance; // realizar as gravações no banco

  //FirebaseUser  user;para funcionar alguma coisa que algum dia vou descobrir - desobri é para saber qual ususario estamos trabalhando(qual esta gravando ou esta passando os dados)

  User user; // instanciando direto a classe User 

  //esta criando uma variavel _loading(privada e falsa(sem valor)) depois da um get no loading para ver qual esta logado
  bool _loading = false;
  bool get loading => _loading;

  /* signIn - apenas um nome qualquer, que recebe a classe User(precisa importar) 
  ela é assync(assincrona) ela vai na autentication procura se existe no banco e retorna
  toda vez que utiliza o async utiliza o await - ele manda a requisição, ele verifica, e volta com a resposta da requisição*/
  /* Future- faz com que seja mais rapida a busca */
  //Function onFail-> quando der algo errado, Function onSuccsess-> quando der algo
  Future<void> signIn({User user, Function onFail, Function onSuccsess}) async {
    try {
      _loading = true; //mostra qual usuario esta logado

      /* criu a variavel result, verificando no AuthResult */
      final AuthResult result = await auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);
          /*mensagem do usuario, no caso ele só vai trazer o email, aparecendo no console, isso serve para ver se esta fazendoa  conexão com o banco  */
          // print(result.user.email); não precisa aparece no terminal
      onSuccsess();
      /* caso de ruim, ele manda uma mensagem de erro  */
    } on PlatformException catch (erro) {
      onFail(getErrorString(erro.code));
    }

    _loading = false; //caso de errado ele voltar o estado o _loading como falso, e mesmo que se certo, ele volta como falso para liberar espaço
  }

  //liberando o registro da tela de cadastro
  Future<void> register(
      {User user, Function onFail, Function onSuccsess}) async {
    try {
      final AuthResult result = await auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
      print(result.user.email);

      user.id = result.user.uid;
      this.user=user;
      await user.saveData();

      onSuccsess();
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }
  }



  set loading(bool value){
    _loading = value;//verifica se é true ou false
    notifyListeners();
  }

    //faz parte da seção do usuario, para aparecer o nome do ususario
    Future<void> _loadCurrentUser({FirebaseUser firebaseUser}) async {
        final FirebaseUser currentUser = firebaseUser ?? await auth.currentUser();
        if(currentUser != null){
          //DocumentSnapshot vai realizar a leitura da coleção no firebase 
        final DocumentSnapshot docUser = await firestore.collection('users').document(currentUser.uid).get();//busca de acordo com o id o usuario
          user = User.fromDocument(docUser);
          //docUser - possui o id do usuario corrente(que está logado)

          notifyListeners();
        }
   }
  
  
   Future<void> facebookLogin({Function onFail, Function onSuccess}) async {
    loading = true;

    final result = await FacebookLogin().logIn(['email', 'public_profile']);

    switch(result.status){
      case FacebookLoginStatus.loggedIn:
        final credential = FacebookAuthProvider.getCredential(
          accessToken: result.accessToken.token
        );

        final authResult = await auth.signInWithCredential(credential);

        if(authResult.user != null){
          final firebaseUser = authResult.user;

          user = User(
            id: firebaseUser.uid,
            name: firebaseUser.displayName,
            email: firebaseUser.email
          );

          await user.saveData();

          onSuccess();
        }
        break;
      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.error:
        onFail(result.errorMessage);
        break;
    }

    loading = false;

  }
}