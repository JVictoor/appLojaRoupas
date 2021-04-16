//inicio do app
//chama a base scren
import 'package:apploja/models/user_manager.dart';
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
    return Provider(
      /* primiera coisa vai ir direto na user manger, instanciando a firebase auth(só sera executado quando tiver o toque no botão), camando o login screen */
      create: (_) => UserManager(),
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
      ),
    );
  }
}

// baseScrren -->