import 'package:apploja/models/user.dart';
import 'package:apploja/models/user_manager.dart';
import 'package:apploja/pages/basescreen.dart';
import 'package:apploja/pages/validators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apploja/pages/cadastrar_useres.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

class LoginScreen extends StatelessWidget {

  //dizendo que essa é a pagina principal
  static const router ='/'; // rota para chamar quando clicar - complemento dela esta na main.dart

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();//para quando cklicar no botão
  
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); //se precisarmos de alguma outra classe

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              children: <Widget>[

                Container(height:40),//espaço

                Container(
                  width: 100,
                  height: 100,
                  child: Image.asset('assets/vestido.png'),//imagem do
                ),
                
                Container(height:30),//espaço


                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(hintText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  validator: (email) {
                    if (!emailValid(email)) return 'E-mail inválido';
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,//altura do e-mail e senha 
                ),
                TextFormField(
                  controller: _passController,
                  decoration: const InputDecoration(hintText: 'Senha'),
                  autocorrect: false,
                  obscureText: true, //símbolos de formatação de senha
                  validator: (pass) {
                    if (pass.isEmpty || pass.length < 6)
                      return 'Senha inválida';
                    return null;
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    child: const Text('Esqueci minha senha'),
                  ),
                ),
                const SizedBox(
                  height: 2,//altura do esqueci minha senha e do cadastre-se
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CadastrarUsersScreen(),
                        ),
                      );
                    },
                    padding: EdgeInsets.zero,
                    child: const Text('Cadastre-se'),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        context.read<UserManager>().signIn(
                            user: User(
                                email: _emailController.text,
                                password: _passController.text),
                            onFail: (e) {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text('Falha ao entrar: $e'),
                                backgroundColor: Colors.red,
                              ));
                            },
                            onSuccsess: () {
                              // TODO: FECHAR TELA DE LOGIN
                              Navigator.push(
                                context,
                                  MaterialPageRoute(builder: (context)=> BaseScreen(),
                                  )
                              );
                            });
                      }
                    },
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    child: const Text(
                      'Entrar',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
              ),
                    SignInButton(
                      Buttons.Facebook,
                      text: 'Entrar com Facebook',
                      onPressed: (){
                        UserManager().facebookLogin();
                      },
                    )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
