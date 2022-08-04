// import 'package:flutter/material.dart';
//
// class PostitionListener extends StatefulWidget {
//   const PostitionListener({Key? key}) : super(key: key);
//
//   @override
//   State<PostitionListener> createState() => _PostitionListenerState();
// }
//
// class _PostitionListenerState extends State<PostitionListener>  with TickerProviderStateMixin {
//   late AnimationController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = AnimationController( vsync: this, duration: const Duration(milliseconds: 1000));
//
//     _controller.addListener(() {
//       //also possible to listen for changes with a listener
//
//     });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(animation: animation, builder: builder);
//   }
// }
