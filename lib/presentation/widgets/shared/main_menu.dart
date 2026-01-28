import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MenuItems {
  final String title;
  final IconData icon;
  final String route;

  MenuItems({required this.title, required this.icon, required this.route});
}

final menuItems = <MenuItems>[
  MenuItems(title: 'Gyroscope', icon: Icons.downloading, route: '/gyroscope'),
  MenuItems(title: 'Accelerometer', icon: Icons.speed, route: '/accelerometer'),
  MenuItems(
    title: 'Magnetometer',
    icon: Icons.explore_outlined,
    route: '/magnetometer',
  ),
  MenuItems(
    title: 'Gyroscope Ball',
    icon: Icons.sports_baseball_outlined,
    route: '/gyroscope-ball',
  ),
  MenuItems(title: 'Compass', icon: Icons.explore, route: '/compass'),
  MenuItems(
    title: 'Pokemons',
    icon: Icons.catching_pokemon,
    route: '/pokemons',
  ),
];

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(
      crossAxisCount: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: menuItems
          .map(
            (item) => HomeMenuItem(
              title: item.title,
              route: item.route,
              icon: item.icon,
            ),
          )
          .toList(),
    );
  }
}

class HomeMenuItem extends StatelessWidget {
  final String title;
  final String route;
  final IconData icon;
  final List<Color> bgColors;

  const HomeMenuItem({
    super.key,
    required this.title,
    required this.route,
    required this.icon,
    this.bgColors = const [Colors.deepPurpleAccent, Colors.deepPurple],
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(route),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: bgColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 40),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
