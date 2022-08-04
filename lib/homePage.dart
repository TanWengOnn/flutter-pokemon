import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pokemon/imageContainer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController( vsync: this, duration: const Duration(milliseconds: 1000));
    _controller.addListener(() {
      //also possible to listen for changes with a listener

    });
  }

  bool jump = false;

  double? x, y;

  GlobalKey key = GlobalKey();
  void getPosition(GlobalKey key) {
    RenderBox? box = key.currentContext?.findRenderObject() as RenderBox?;
    Offset? position = box?.localToGlobal(Offset.zero);
        x = position?.dx;
        y = position?.dx;
  }


  @override
  Widget build(BuildContext context) {
    // while(true){
    //   print(x);
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text("Pokemon Jump"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ImageContainer(gameImage:"assets/jump.png"),
            // ImageContainer(gameImage:"assets/stone.png"),
            Container(
              width: 400,
              height: 500,
              color: Colors.greenAccent,
              child: Stack(children: [
                AnimatedPositioned(
                  key: key,
                  width: 100,
                  height: 100,
                  top: jump ? 100 : 250,
                  left: 150,
                  duration: const Duration(milliseconds: 100),
                  //curve: Curves.fastOutSlowIn,
                  child:  Image(image: AssetImage("assets/jump.png")),
                ),
                AnimatedPositioned(
                  width: 100,
                  height: 100,
                  top: 285,
                  left: 300,  // 0 - 300
                  duration: const Duration(seconds: 2),
                  curve: Curves.fastOutSlowIn,
                  child:  Image(image: AssetImage("assets/stone.png")),
                ),
              ]),
            ),
            Container(
              color: Colors.black,
              width: 100,
              height: 50,
              child: GestureDetector(
                onPanDown: (details) {
                  getPosition(key);
                  setState(() {
                    jump = true;
                    print(jump);
                    print("position: $x");
                  });
                },
                onPanEnd: (details) {
                  getPosition(key);
                  setState(() {
                    jump = false;
                    print(jump);
                    print("position: $x");
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
