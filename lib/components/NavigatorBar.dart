import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<Color> iconColors;

  const CustomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
    this.iconColors = const [Colors.blue, Colors.blue, Colors.blue, Colors.blue],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: Colors.blue, 
      unselectedItemColor: Colors.grey, 
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
            color: iconColors[0], 
          ),
          label: "Buscador",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.shopping_cart,
            color: iconColors[1], 
          ),
          label: "Carrito",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.history,
            color: iconColors[2], 
          ),
          label: "Vistos",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: iconColors[3], 
          ),
          label: "Perfil",
        ),
      ],
    );
  }
}
