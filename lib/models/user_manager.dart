/* classe gerenciadora dos usuarios, verifica quais users estão cadastrados */
//aqui éa continuação dos dados para cadastro, onde esta ligando os dados com o banco
import 'package:apploja/helpers/firebase_errors.dart';
import 'package:apploja/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class UserManager {
/* utiliza o Firebase Auth, instanciando ela, jogando em auth para pegar o metodo sigIn para verificar se o password é valido*/
  final FirebaseAuth auth = FirebaseAuth.instance;//fazer a autenticação do e-mail e senha
  
  final Firestore firestore = Firestore.instance;// realizar as gravações no banco

  FirebaseUser user;//para funcionar alguma coisa que algum dia vou descobrir - desobri é para saber qual ususario estamos trabalhando(qual esta gravando ou esta passando os dados)

/* signIn - apenas um nome qualquer, que recebe a classe User(precisa importar) 
ela é assync(assincrona) ela vai na autentication procura se existe no banco e retorna
toda vez que utiliza o async utiliza o await - ele manda a requisição, ele verifica, e volta com a resposta da requisição*/
/* Future- faz com que seja mais rapida a busca */
//Function onFail-> quando der algo errado, Function onSuccsess-> quando der algo
  Future<void> signIn({User user, Function onFail, Function onSuccsess}) async {
    try {
      /* criu a variavel result, verificando no AuthResult */
      final AuthResult result = await auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);

/*mensagem do usuario, no caso ele só vai trazer o email, aparecendo no console, isso serve para ver se esta fazendoa  conexão com o banco  */
      print(result.user.email);
      onSuccsess();
/* caso de ruim, ele manda uma mensagem de erro  */
    } on PlatformException catch (erro) {
      onFail(getErrorString(erro.code));
    }
  }
//liberando o registro da tela de cadastro
  Future<void> register({User user, Function onFail, Function onSuccsess}) async {
    try {
      final AuthResult result = await auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
      print(result.user.email);

      user.id = result.user.uid;
      await user.saveData();

      onSuccsess();
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }
  }
 
 Future<void> _loadCurrentUser() async {
    final FirebaseUser currentUser = await auth.currentUser();
    if (currentUser != null) {
      user = currentUser;
      print(user.uid);
    }
    
  }





}

