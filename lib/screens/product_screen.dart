import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/blocs/product_bloc.dart';
import 'package:loja_virtual/validators/product_validator.dart';
import 'package:loja_virtual/widgets/images_widget.dart';
import 'package:loja_virtual/widgets/product_sizes.dart';

class ProductScreen extends StatefulWidget {

  final String categoryId;
  final DocumentSnapshot product;

  ProductScreen({this.categoryId, this.product});

  @override
  _ProductScreenState createState() => _ProductScreenState(categoryId, product);
}

class _ProductScreenState extends State<ProductScreen> with ProductValidator {

  final ProductBloc _productBloc;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _ProductScreenState(String categoryId, DocumentSnapshot product) :
        _productBloc = ProductBloc(categoryId: categoryId, product: product);

  @override
  Widget build(BuildContext context) {

    InputDecoration _buildDecoration(String label){
      return InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey)
      );
    }

    final _fieldStyle = TextStyle(
        color: Colors.black,
        fontSize: 16
    );

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: StreamBuilder<bool>(
            stream: _productBloc.outCreated,
            initialData: false,
            builder: (context, snapshot) {
              return Text(snapshot.data ? "Editar vacina ou medicamento" : "Nova vacina ou medicamento ");
            }
        ),
        actions: <Widget>[
          StreamBuilder<bool>(
            stream: _productBloc.outCreated,
            initialData: false,
            builder: (context, snapshot){
              if(snapshot.data)
                return StreamBuilder<bool>(
                    stream: _productBloc.outLoading,
                    initialData: false,
                    builder: (context, snapshot) {
                      return IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: snapshot.data ? null : (){
                          _productBloc.deleteProduct();
                          Navigator.of(context).pop();
                        },
                      );
                    }
                );
              else return Container();
            },
          ),
          StreamBuilder<bool>(
              stream: _productBloc.outLoading,
              initialData: false,
              builder: (context, snapshot) {
                return IconButton(
                  icon: Icon(Icons.save),
                  onPressed: snapshot.data ? null : saveProduct,
                );
              }
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Form(
            key: _formKey,
            child: StreamBuilder<Map>(
                stream: _productBloc.outData,
                builder: (context, snapshot) {
                  if(!snapshot.hasData) return Container();
                  return ListView(
                    padding: EdgeInsets.all(16),
                    children: <Widget>[
                      Text(
                        "Imagens",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12
                        ),
                      ),
                      ImagesWidget(
                        context: context,
                        initialValue: snapshot.data["images"],
                        onSaved: _productBloc.saveImages,
                        validator: validateImages,
                      ),
                      TextFormField(
                        initialValue: snapshot.data["name"],
                        style: _fieldStyle,
                        decoration: _buildDecoration("Nome"),
                        onSaved: _productBloc.saveName,
                        validator: validateName,
                      ),
                      TextFormField(
                        initialValue: snapshot.data["description"],
                        style: _fieldStyle,
                        maxLines: 6,
                        decoration: _buildDecoration("Descrição"),
                        onSaved: _productBloc.saveDescription,
                        validator: validateDescription,
                      ),
                      TextFormField(
                        initialValue: snapshot.data["date"],
                        style: _fieldStyle,
                        decoration: _buildDecoration("Data"),
                        onSaved: _productBloc.saveDate,
                        validator: validateDate,
                      ),
                      SizedBox(height: 16,),
                      Text(
                        "Reaplicado",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12
                        ),
                      ),
                      ProductSizes(
                        context: context,
                        initialValue: snapshot.data["reapplied"],
                        onSaved: _productBloc.saveReapplied,
//                        validator: (s){
//                          if(s.isEmpty) return "";
//                        },
                      )
                    ],
                  );
                }
            ),
          ),
          StreamBuilder<bool>(
              stream: _productBloc.outLoading,
              initialData: false,
              builder: (context, snapshot) {
                return IgnorePointer(
                  ignoring: !snapshot.data,
                  child: Container(
                    color: snapshot.data ? Colors.black54 : Colors.transparent,
                  ),
                );
              }
          ),
        ],
      ),
    );
  }

  void saveProduct() async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();

      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text("Salvando vacina ou medicamento", style: TextStyle(color: Colors.white),),
            duration: Duration(minutes: 1),

          )
      );

      bool success = await _productBloc.saveProduct();

      _scaffoldKey.currentState.removeCurrentSnackBar();

      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text(success ? "Vacina ou Medicamento salvo!" : "Erro ao salvar vacina ou medicamento!", style: TextStyle(color: Colors.white),),

          )
      );
    }
  }

}
