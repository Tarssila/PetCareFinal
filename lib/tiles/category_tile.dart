import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/widgets/edit_category_dialog.dart';

import '../screens/product_screen.dart';

class CategoryTile extends StatelessWidget {

  final DocumentSnapshot category;

  CategoryTile(this.category);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        child: ExpansionTile(
          leading: GestureDetector(
            onTap: (){
              showDialog(context: context,
                  builder: (context) => EditCategoryDialog(
                    category: category,
                  )
              );
            },
            child: CircleAvatar(
              backgroundImage: NetworkImage(category.data["icon"]),
              backgroundColor: Colors.transparent,
            ),
          ),
          title: Text(
            category.data["title"],
            style: TextStyle(color: Colors.grey[850], fontWeight: FontWeight.w500),
          ),
          children: <Widget>[
            FutureBuilder<QuerySnapshot>(
              future: category.reference.collection("items").getDocuments(),
              builder: (context, snapshot){
                if(!snapshot.hasData) return Container();
                return Column(
                  children: snapshot.data.documents.map((doc){
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(doc.data["images"][0]),
                      ),
                      title: Text(doc.data["name"]),
                      trailing: Text(
                          doc.data["date"]
                      ),
                      onTap: (){
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => ProductScreen(
                              categoryId: category.documentID,
                              product: doc,
                            ))
                        );
                      },
                    );
                  }).toList()..add(
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Icon(Icons.add, color: Theme.of(context).primaryColor,),
                        ),
                        title: Text("Adicionar"),
                        onTap: (){
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => ProductScreen(
                                categoryId: category.documentID,
                              ))
                          );
                        },
                      )
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
