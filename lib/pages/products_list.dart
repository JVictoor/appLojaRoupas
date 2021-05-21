//tela de listagem dos produtos
//
//
import 'package:apploja/models/products.dart';
import 'package:flutter/material.dart';

class ProductsList extends StatelessWidget {
	
	  ProductsList(this.product);
	
	  final Products product;
	
	  @override
	  Widget build(BuildContext context) {
	    return Card(
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
	    );
	  }
	}