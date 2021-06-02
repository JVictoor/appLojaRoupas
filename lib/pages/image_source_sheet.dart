//aqui é onde puxa as imagens da galeria do celular
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {
/*   
FAZ PARAR DE DAR ERRO NO IMAGENS_FORM.DART, FAZ PARTE DA IMPORTAÇÃO DE ACESSO A GALERIA E PEGAR IMAGENS DA CAMERA
VAI PERGAR A IMAGEM E VER SE É DA GALERIA OU DA CAMERA E TRAZER A IMPORTAÇÃO
 */
  ImageSourceSheet({this.onImageSelected});
  final Function(File) onImageSelected;
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          FlatButton(
           onPressed: () async {
             //PickedFile => para camera, para pegar o endereço da imagem da galeria ou da propria camera
             final PickedFile file =
             await picker.getImage(source: ImageSource.camera);//essa linha abre a camera do cell
             onImageSelected(File(file.path));//pega o caminho ca imagem e joga no arquivo
           },
            child: const Text('Câmera'),
          ),
          FlatButton(
           onPressed: () async {
                final PickedFile file =
                  await picker.getImage(source: ImageSource.gallery);//onde ta acusando o erro / onde abre a camera
                onImageSelected(File(file.path));
            },    
            child: const Text('Galeria'),
          ),
        ],
      ),
    );
  }
}