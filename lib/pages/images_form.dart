//serve para mostrar as imagens do formulario


import 'dart:io';// importando para não dar erro no File da verificação de imagem
import 'package:apploja/models/products.dart';
import 'package:apploja/pages/image_source_sheet.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class ImagesForm extends StatelessWidget {

  const ImagesForm(this.products);

  final Products products;

  @override
  Widget build(BuildContext context) {
    return FormField<List<dynamic>>(
      initialValue: products.images,
      builder: (state){

        return AspectRatio(
          aspectRatio: 1,
          child: Carousel(
            images: state.value.map<Widget>((image){// vai mapear as imagens para levar para o carrosel para editar caso tenha mais de uma imagem
              return Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  if(image is String)//traz a imagem como string
                    Image.network(image, fit: BoxFit.cover,)//caminho da imagem, vai ver se é um arquivo ou um network
                  else
                    Image.file(image as File, fit: BoxFit.cover,),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(Icons.delete_outline_rounded),//botão para remover a imagem
                      color: Colors.red,//cor vermelha
                      onPressed: (){
                        state.value.remove(image);
                        state.didChange(state.value);
                      },
                    ),
                  )
                ],
              );
                //para listar as imagens
            }).toList()..add(
              Material(
                color: Colors.grey[100],
                child: IconButton(
                  icon: Icon(Icons.add_a_photo),
                  color: Theme.of(context).primaryColor,
                  iconSize: 50,
                  onPressed: (){
                    showModalBottomSheet(
                        context: context,
                        builder: (_) => ImageSourceSheet()
                    );
                  },
                ),
              ) 
            ),

            dotSize: 4,
            dotSpacing: 15,
            dotBgColor: Colors.transparent,
            dotColor: Theme.of(context).primaryColor,
            autoplay: false,
          ),
        );
      },
    );
  }
}