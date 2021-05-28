//tela de listagem dos produtos
//
//
import 'package:apploja/models/products.dart';
import 'package:apploja/models/products_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';// resolve o problema do read

class ProductsList extends StatelessWidget {
	
	  ProductsList(this.product);
	
	  final Products product;
	
	  @override
	  Widget build(BuildContext context) {

            return GestureDetector(
					onTap: () {
						//acessando o método para selecionar o produto clicado abrindo a
						//tela de produtos
						context.read<ProductsManager>().productSelected(product);
						Navigator.of(context).pushNamed('/loadproduct', arguments: product);//vai acessar a tela de load_product_screen.dart
		    },



	    child: Card(
	      shape: RoundedRectangleBorder(
	        borderRadius: BorderRadius.circular(4)
	      ),
	      child: Container(
	        height: 100,
	        padding: const EdgeInsets.all(8),
	        child: Row(
	          children: <Widget>[
	            AspectRatio(
	              aspectRatio: 1,
	              child: Image.network(product.images.first),
	            ),
	            const SizedBox(width: 16,),
	            Expanded(
	              child: Column(
	                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
	                crossAxisAlignment: CrossAxisAlignment.start,
	                children: <Widget>[
	                  
                    //mostra os valores gravados
                    Text(
	                    product.color,
	                    style: TextStyle(
	                      fontSize: 16,
	                      fontWeight: FontWeight.w800,
	                    ),
	                  ),

                    Text(
	                    product.model,
	                    style: TextStyle(
	                      fontSize: 16,
	                      fontWeight: FontWeight.w800,
	                    ),
	                  ),

                    Text(
	                    "RS " + product.price,
	                    style: TextStyle(
	                      fontSize: 16,
	                      fontWeight: FontWeight.w800,
	                    ),
	                  ),
                    
                    Text(
	                    product.size,
	                    style: TextStyle(
	                      fontSize: 16,
	                      fontWeight: FontWeight.w800,
	                    ),
	                  ),
	                ],
	              ),
	            )
	          ],
	        ),
	      ),
      )
	    );
	  }
	}