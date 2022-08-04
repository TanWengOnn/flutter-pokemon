import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pokemon/imageContainer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  late AnimationController _characterController;
  late AnimationController _stoneController;
  late Animation _character;
  late Animation _stone;
  bool jump = false;
  bool collision = false;
  bool addScore = false;
  int score = 0;

  @override
  void initState() {
    super.initState();

    _characterController = AnimationController( vsync: this, duration: const Duration(milliseconds: 200));
    _stoneController = AnimationController( vsync: this, duration: const Duration(milliseconds: 1000));
    _character = Tween<double>(begin: 250, end: 150).animate(_characterController);
    _stone = Tween<double>(begin: 0, end: 300).animate(_stoneController);

    _stoneController.forward();
    _stoneController.repeat(reverse: true);


    _stoneController.addListener(() {
      if (_character.value == 250 && (_stone.value > 148 && _stone.value < 152)){
        //print("test");
        setState(() {
          collision = true;
        });
      } else {
        setState(() {
          collision = false;
        });
      }

      if ( (_stone.value > 148 && _stone.value < 152) && _character.value != 250) {
        setState(() {
          addScore = true;
        });
      } else {
        setState(() {
          addScore = false;
        });
      }

    });
  }

  @override
  void dispose() {
    _stoneController.dispose();
    _characterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (collision){
      score -= 1;
      print("Score: $score");
    }

    if (addScore){
      score += 1;
      print("Score: $score");
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokemon Jump"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Score: $score"),
            Container(
              width: 400,
              height: 500,
              color: Colors.greenAccent,
              child: Stack(children: [
                AnimatedBuilder(
                  child: jump ? ImageContainer(gameImage: "assets/jump.png") : ImageContainer(gameImage: "assets/stay.png") ,
                  animation: _character,
                  builder: (_, Widget? child) {
                    if (jump) {
                      //print(_character.value);
                      _characterController.forward();
                    } else {
                      _characterController.reverse();
                    }
                    return Transform.translate(
                      offset: Offset(
                          150, _character.value),
                      child: child,
                    );
                  },
                ),
                AnimatedBuilder(
                  child: ImageContainer(gameImage: "assets/stone.png"),
                  animation: _stone,
                  builder: (_, Widget? child) {
                    //print("stone: ${_stone.value}");
                    return Transform.translate(
                      offset: Offset(_stone.value, 285),
                      child: child,
                    );
                  },
                ),
              ]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  color: Colors.blueAccent,
                  width: 100,
                  height: 50,
                  child: Stack(
                    children: [
                      Center(child: Text("Jump")),
                      GestureDetector(
                        onPanDown: (details) {
                          setState(() {
                            jump = true;
                            //print(jump);
                          });
                        },
                        onPanEnd: (details) {
                          setState(() {
                            jump = false;
                            //print(jump);
                          });
                        },
                      ),
                    ]
                  ),
                ),
                Container(
                  color: Colors.blueAccent,
                  width: 100,
                  height: 50,
                  child: Stack(
                      children: [
                        Center(child: Text("Reset")),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Navigator.pushReplacementNamed(context, '/');
                              Navigator.popAndPushNamed(context, '/');
                            });
                          },
                        )
                      ]
                  ),
                )
              ],
            ),

          ],
        ),
      ),
    );
  }
}
