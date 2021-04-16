import 'package:apploja/models/user.dart';
import 'package:apploja/models/user_manager.dart';
import 'package:apploja/pages/basescreen.dart';
import 'package:apploja/pages/validators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apploja/pages/cadastrar_useres.dart';

class LoginScreen extends StatelessWidget {

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
                  height: 16,
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
                  height: 16,
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
