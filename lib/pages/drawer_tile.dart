// ver qual item foi clicaco e colocar a cor nos itens
// toda a estilziaão dos textos e de tudo que chama aqui

import 'package:apploja/models/page_manager.dart';
import 'package:apploja/pages/cadastrar_products.dart';
import 'package:apploja/pages/cadastrar_useres.dart';
import 'package:apploja/pages/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile({this.iconData, this.title, this.page});

  final IconData iconData;
  final String title;
  final int page;

  @override
  Widget build(BuildContext context) {

    final int curPage = context.watch<PageManager>().page;//importação do provider

    return InkWell(
          //aqui pe onde chama a pagina que queremos, esse if page==1 ele chama o topico que esta reçacionado no numero 1 do custom_dreawer.
      
      onTap: () {
        //aqui chama a pagina que queremos
       context.read<PageManager>().setPage(page);
      
//funciona, mas o de cima é mais fofo *-*
/*         if (page == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CadastrarProductsScreen(),
            ),
          );
        }
        if (page == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CadastrarProductsScreen(),
            ),
          );
        }
        if (page == 5) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
          );
        } */
      },

      child: SizedBox(
        height: 60,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Icon(
                iconData,
                size: 32,
                //coloca na pagina corrente a cor selecionada
                color: curPage == page ? Colors.red : Colors.grey[700],
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                //coloca na pagina corrente a cor selecionada
                color: curPage == page ? Colors.red : Colors.black87, 
              ),
            )
          ],
        ),
      ),
    );
  }
}
