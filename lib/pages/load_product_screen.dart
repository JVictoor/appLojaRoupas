//tela que aparece a seleção do produto quando clica nele

import 'package:apploja/models/products_manager.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadProductScreen extends StatelessWidget {

  static const router = '/loadproduct';

  @override
  Widget build(BuildContext context) {
    
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        actions: [
            IconButton(
              icon: Icon(Icons.edit), 
              onPressed: (){
                  Navigator.of(context).pushNamed('/editprodutct');
              }
            ),

            IconButton(
              icon: Icon(Icons.shopping_cart), 
              onPressed: (){
               
              }
            ),
           ],
         title: Consumer<ProductsManager>(builder: (_, manager, __) {
            return Text(manager.products?.model);
         }),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body:Consumer<ProductsManager>(builder: (_, manager, __){     
     
      return ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1,
            child: Carousel(
              images: manager.products.images.map((url){
                return NetworkImage(url);
              }).toList(),
              dotSize: 4,
              dotSpacing: 15,
              dotBgColor: Colors.transparent,
              dotColor: primaryColor,
              autoplay: false,
            ),
          ),
         
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  manager.products.color,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                  ),
                ),            
                Text(
                  manager.products.size,
                  style: const TextStyle(
                    fontSize: 16
                  ),
                ),                
              ],
            ),
          )
        ],
      );
    })
    );
  }
}