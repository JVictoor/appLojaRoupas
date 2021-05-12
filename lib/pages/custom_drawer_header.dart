//cabeçalho que aparece em cima do MENU

import 'package:apploja/models/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CustomDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 24, 16, 8),
      height: 180,
      child: Consumer<UserManager>(//importando para mostrar o nome de quem ta logado apartid o metodo da usermanager, e o consumer esta dentro do provider
        builder: (_, userManager, __){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                'Loja FEF',
                style: TextStyle(
                  fontSize: 34,//tamanho da fonte
                  fontWeight: FontWeight.bold,//bold negrito
                ),
              ),
             
              Text(
                'Olá, ${userManager.user?.name ?? ''}',//esta relacionaod com o user_manager (_loadCurrentUser)
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}