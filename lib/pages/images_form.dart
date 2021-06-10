//serve para mostrar as imagens do formulario

import 'dart:io'; // importando para não dar erro no File da verificação de imagem
import 'package:apploja/models/products.dart';
import 'package:apploja/pages/image_source_sheet.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ImagesForm extends StatelessWidget {
  const ImagesForm(this.product);

  final Products product;

  @override
  Widget build(BuildContext context) {
    
    return FormField<List<dynamic>>(

      //faz a lista de produtos
      initialValue: List.from(product.images),
      validator: (images) {
        if (images.isEmpty) return 'Insira ao menos uma imagem';//se a lista estiver vazia ele retorna essa msgn
        return null;
      },

      //alterando e peganos as novas imagens apos as alterações feitas, salvando em newImages
      onSaved: (images) => product.newImages = images,//faz referencia ao List<dynamic> newImages; do products.dart

      //onImageSelected metodo para chamar o arquivo, vai adicionar o arquivo da galeria ou da camera
      builder: (state) {
        void onImageSelected(File file) {
          state.value.add(file);//pega da galeria ou do cell e add
          state.didChange(state.value);//altera o estado com o valor da imagem
          Navigator.of(context).pop();//retorna na tela do eddit, essa imagem que vai ser chamada
        }

       //cria a coluna para mostrar a imagem
        return Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1,
              child: Carousel(
                // vai mapear as imagens para levar para o carrosel para editar caso tenha mais de uma imagem
                images: state.value.map<Widget>((image) { 
                  return Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      //traz a imagem como string e verifica se é da internet ou se é da galeria
                      if (image is String)//caminho da imagem, vai ver se é um arquivo ou um network
                        Image.network(//caminho da imagem, vai ver se é um arquivo ou um network
                          image,
                          fit: BoxFit.cover,
                        )
                      else
                        Image.file(//ou se é uma imagem de camera ou da galeria
                          image as File,
                          fit: BoxFit.cover,
                        ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(Icons.delete_forever),//botão para remover a imagem
                          color: Colors.red,
                          onPressed: () {
                            state.value.remove(image);
                            state.didChange(state.value);
                          },
                        ),
                      )
                    ],
                  );
                }).toList()
                //caso contrario das verificaçẽs vamos adicionar uma imagem
                  ..add(Material(
                    color: Colors.grey[100],
                    child: IconButton(
                      icon: Icon(Icons.add_a_photo),//botão de imagem
                      color: Theme.of(context).primaryColor,
                      iconSize: 50,
                      onPressed: () {
                        if (Platform.isAndroid)//verifica a plataforma, se é android ou IOS
                          //verifica se é foto
                          showModalBottomSheet(
                              context: context,
                              builder: (_) => ImageSourceSheet(
                                    onImageSelected: onImageSelected,
                                  ));
                        else
                        //ou se é galeria
                          showCupertinoModalPopup(
                              context: context,
                              builder: (_) => ImageSourceSheet(
                                    onImageSelected: onImageSelected,
                                  ));
                      },
                    ),
                  )),
                dotSize: 4,
                dotSpacing: 15,
                dotBgColor: Colors.transparent,
                dotColor: Theme.of(context).primaryColor,
                autoplay: false,
              ),
            ),
            
            //se tiver algum erro, manda essa msgm
            if (state.hasError)
              Container(
                margin: const EdgeInsets.only(top: 16, left: 16),
                alignment: Alignment.centerLeft,
                child: Text(
                  state.errorText,
                  style: const TextStyle(
                    color: Colors.red,//cor vermelha da msgm
                    fontSize: 12,
                  ),
                ),
              )
          ],
        );
      },
    );
  }
}
