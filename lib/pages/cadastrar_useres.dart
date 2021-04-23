import 'package:apploja/models/user.dart';
import 'package:apploja/models/user_manager.dart';
import 'package:apploja/pages/validators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CadastrarUsersScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); //para quando cklicar no botão

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final User user = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //stados fixos
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Criar Conta'),
        centerTitle: true,
      ),
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
                  decoration: const InputDecoration(hintText: 'Nome Completo'),
                  validator: (name) {
                    if (name.isEmpty)
                      return 'Campo obrigatório';
                    else if (name.trim().split(' ').length <= 1)
                      return 'Preencha seu Nome completo';
                    return null;
                  },
                  onSaved: (name) => user.name = name,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'CPF Completo'),
                  validator: (cpf) {
                    if (cpf.isEmpty)
                      return 'Campo obrigatório';
                    else if (cpf.length <= 13)
                      return 'Preencha seu CPF completo';
                    return null;
                  },
                  onSaved: (cpf) => user.cpf = cpf,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (email) {
                    if (email.isEmpty)
                      return 'Campo obrigatório';
                    else if (!emailValid(email)) return 'E-mail inválido';
                    return null;
                  },
                  onSaved: (email) => user.email = email,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Senha'),
                  obscureText: true,
                  validator: (pass) {
                    if (pass.isEmpty)
                      return 'Campo obrigatório';
                    else if (pass.length < 6)
                      return 'Senha deve ter de 6 a 12 caracteres!';
                    return null;
                  },
                  onSaved: (pass) => user.password = pass,
                ),
                const SizedBox(
                  height: 16,
                ),
               
                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    disabledColor:Theme.of(context).primaryColor.withAlpha(100),
                    textColor: Colors.white,
                    //aqui acontece a magica de validar
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        context.read<UserManager>().register(
                            user: user,
                            onSuccsess: () {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text('Cadastro realizado com sucesso'),
                                backgroundColor: Colors.pink[300],
                              ));
                              debugPrint('sucesso');
                              // TODO: POP
                            },
                            onFail: (e) {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text('Falha ao cadastrar: $e'),
                                backgroundColor: Colors.red[700],
                              ));
                            });
                      }
                    },
                    child: const Text(
                      'Enviar',
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
