import 'package:apploja/models/products.dart';
import 'package:apploja/models/products_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CadastrarProductsScreen extends StatelessWidget {
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); //para quando cklicar no botão

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final Products products = Products();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
 
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Cadastrar Produtos'),
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
                Container(
                  width: 100,
                  height: 100,
                  child: Image.asset('assets/vestido.png'),
                ),

                Container(height: 30), //espaço

                TextFormField(
                  decoration: const InputDecoration(hintText: 'Cor do Produto'),
                  validator: (gender) {
                    if (gender.isEmpty) return 'Campo obrigatório!';
                    return null;
                  },
                  onSaved: (color) => products.color = color,
                ),

                TextFormField(
                  decoration: const InputDecoration(hintText: 'Modelo Gola'),
                  validator: (gender) {
                    if (gender.isEmpty) return 'Campo obrigatório!';
                    return null;
                  },
                  onSaved: (model) => products.model = model,
                ),
                const SizedBox(
                  height: 16,
                ),

                TextFormField(
                  decoration:
                      const InputDecoration(hintText: 'Tamanho da Roupa'),
                  validator: (gender) {
                    if (gender.isEmpty) return 'Campo obrigatório!';
                    return null;
                  },
                  onSaved: (size) => products.size = size,
                ),
                const SizedBox(
                  height: 16,
                ),

                TextFormField(
                  decoration:
                      const InputDecoration(hintText: 'Valor em Reais '),
                  validator: (gender) {
                    if (gender.isEmpty) return 'Campo obrigatório!';
                    return null;
                  },
                  onSaved: (price) => products.price = price,
                ),
                const SizedBox(
                  height: 16,
                ),

                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    disabledColor:
                        Theme.of(context).primaryColor.withAlpha(100),
                    textColor: Colors.white,
                    //aqui acontece a magica de validar
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        context.read<ProductsManager>().registro(
                            products: products,
                            onSuccess: () {
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
