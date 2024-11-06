import 'package:flutter/material.dart';

class MenuOption {
  String route;
  Widget screen; 
  IconData icon; 
  String description; 

  MenuOption(
    {required this.route,
    required this.screen,
    required this.icon,
    required this.description});
}