// ver qual item foi clicaco e colocar a cor nos itens
// toda a estilziaão dos textos e de tudo que chama aqui

import 'package:apploja/pages/loginscreen.dart';
import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile({this.iconData, this.title, this.page});

  final IconData iconData;
  final String title;
  final int page;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //aqui pe onde chama a pagina que queremos, esse if page==1 ele chama o topico que esta reçacionado no numero 1 do custom_dreawer.
      onTap: () {
        if (page == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
          );
        }
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
                color: Colors.grey[700],
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black87,
              ),
            )
          ],
        ),
      ),
    );
  }
}
