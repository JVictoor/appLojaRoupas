//itens do menu
//tem as abas do menu
import 'package:apploja/pages/custom_drawer_header.dart';
import 'package:apploja/pages/drawer_tile.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      //um risco traçando o cabeçalho
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 203, 236, 241), //alterar essa cor
                Colors.white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
          ),

          //custom DrawerHead
          ListView(
            children: <Widget>[
              CustomDrawerHeader(),
              const Divider(),
              DrawerTile(
                iconData: Icons.home_outlined, //modelo do icone
                title: 'Início',
                page: 0,
              ),
              DrawerTile(
                iconData: Icons.app_registration, //modelo do icone
                title: 'Cadastro',
                page: 1,
              ),
              DrawerTile(
                iconData: Icons.list_alt,
                title: 'Listar',
                page: 2,
              ),
              DrawerTile(
                iconData: Icons.photo_camera_back,
                title: 'Fotos',
                page: 3,
              ),
              DrawerTile(
                iconData: Icons.playlist_add_check_outlined,
                title: 'Meus Pedidos',
                page: 4,
              ),
              DrawerTile(
                iconData: Icons.location_on,
                title: 'Lojas Parceiras',
                page: 5,
              ),
              DrawerTile(
                iconData: Icons.exit_to_app_sharp,
                title: 'Sair',
                page: 6,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
