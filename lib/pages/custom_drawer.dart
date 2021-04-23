//itens do menu
//tem as abas do menu
import 'package:apploja/pages/drawer_tile.dart';
import 'package:flutter/material.dart';


class CustomDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(//acrescenta a cor no fundo do menu
        color: Colors.pink[200], // pink no fundo do menu

      child: ListView(
        children: <Widget>[
          DrawerTile(
            iconData: Icons.home_outlined,//modelo do icone
            title: 'Início',
            page: 0,
          ),
          DrawerTile(
            iconData: Icons.list_alt,
            title: 'Produtos',
            page: 1,
          ),
          DrawerTile(
            iconData: Icons.photo_camera_back,
            title: 'Fotos',
            page: 2,
          ),
          DrawerTile(
            iconData: Icons.playlist_add_check_outlined,
            title: 'Meus Pedidos',
            page: 3,
          ),
          DrawerTile(
            iconData: Icons.location_on,
            title: 'Lojas Parceiras',
            page: 4,
          ),
          
          DrawerTile(
              iconData: Icons.exit_to_app_sharp,
              title: 'Sair',
              page: 5,
            ),
        ],
      ),
    )
    );
  }
}
