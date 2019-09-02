import 'package:filter_animation/FilterOptions.dart';
import "package:flutter/material.dart";
void main()
{
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(home:Scaffold(appBar: AppBar(title:Text("Google Io Filter Animation Demo")),
    body: FilterOptions(),));
  }
  
}