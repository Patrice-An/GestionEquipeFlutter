import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget{
    final String name;

    const MyAppBar({required this.name});

    @override
    Widget build(BuildContext context){
      return AppBar(
        title: this.name.toString()
      );
    }
}