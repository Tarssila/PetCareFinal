import 'package:flutter/material.dart';
import 'package:loja_virtual/tabs/home_tab.dart';
import 'package:loja_virtual/tabs/products_tab.dart';
import 'package:loja_virtual/widgets/cart_button.dart';
import 'package:loja_virtual/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
            appBar: AppBar(
              title: Text("Pet Care"),
              centerTitle: true,
            ),
          drawer: CustomDrawer(_pageController),
          body: Form(
                child: ListView(
                  padding: EdgeInsets.all(20.0),
                  children: <Widget>[
                    SizedBox(height: 100.0,),
            SizedBox(
              width: 100,
              height: 100,
              child: Image.asset("images/logo.png"),
            ),
            SizedBox(
              height: 10,
            ),

            SizedBox(height: 16.0,),

            Row(

              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox (width: 120.0,),
                Text(
                  "Pet Care",

                  style: TextStyle(fontSize: 20.0,
                      fontWeight: FontWeight.bold
                      ),

                ),
                SizedBox (width: 8.0,),

              ],
            ),
                    SizedBox(height: 20.0,),
                    Row(

                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox (width: 20.0,),
                        Text(
                          "Aplicativo para controle de vacinas e"
                              ,


                          style: TextStyle(fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),

                        ),
                        SizedBox (width: 8.0,),

                      ],
                    ),
                    SizedBox(height: 5.0,),
                    Row(

                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox (width: 20.0,),
                        Text(
                          "medicações de animais domésticos.",


                          style: TextStyle(fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),

                        ),
                        SizedBox (width: 8.0,),

                      ],
                    ),

          ],
        ),
      )



          //floatingActionButton: CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Pets"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: ProductsTab(),
          floatingActionButton: CartButton(),
        ),
      ],
    );
  }
}
