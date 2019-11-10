import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/pet_screen.dart';
import 'package:loja_virtual/widgets/edit_category_dialog.dart';

class CartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add, color: Colors.white,),
      onPressed: (){
        showDialog(context: context,
          builder: (context) => EditCategoryDialog()

        );
      },
    );
  }
}
