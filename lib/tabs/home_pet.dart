import 'package:flutter/material.dart';


class HomePet extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text("Pet Care"),
                centerTitle: true,
              ),
            ),

          ],
        )
      ],
    );
  }
}
