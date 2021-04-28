//inicio do app
//chama a base scren
import 'package:apploja/models/products.dart';
import 'package:apploja/models/products_manager.dart';
import 'package:apploja/models/user_manager.dart';
import 'package:apploja/pages/cadastrar_products.dart';
//import 'package:apploja/pages/basescreen.dart';
import 'package:apploja/pages/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     //multiprovader tras multipĺas telas
     return MultiProvider(
      /* primiera coisa vai ir direto na user manger, instanciando a firebase auth(só sera executado quando tiver o toque no botão), camando o login screen */
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false, // verifica qual vai ser ativado
        ),
      
        ChangeNotifierProvider(
          create: (_) => ProductsManager(),
          lazy: false,
        ),
      ],



      child: MaterialApp(
        title: 'applojavirtual',
        debugShowCheckedModeBanner: false, // retira o banner
        theme: ThemeData(
          primarySwatch: Colors.pink, //cor pink
          visualDensity: VisualDensity
              .adaptivePlatformDensity, //indentidade do visual de acordo com a plataforma
        ),

        //home: Container(), // chama a container de primeira
        // home: BaseScreen(),// chama a basescren de primeira
        home: LoginScreen(), //chama o login de primeira
       //home: CadastrarProductsScreen(),
        
        
      ),
    );
  }
}

// baseScrren -->