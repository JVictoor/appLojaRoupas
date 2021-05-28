//aqui é onde puxa as imagens da galeria do celular

import 'package:flutter/material.dart';

class ImageSourceSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          FlatButton(
            onPressed: () {},
            child: const Text('Câmera'), //botão para camera
          ),
          FlatButton(
            onPressed: () {},
            child: const Text('Galeria'), //botão para galeria
          ),
        ],
      ),
    );
  }
}
