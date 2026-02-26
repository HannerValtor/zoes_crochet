import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWeb = size.width > 800;

    return AppBar(
      backgroundColor: const Color(0xFFF5EDE4),
      elevation: 0,
      centerTitle: !isWeb,
      title: GestureDetector(
        onTap: () {
          Navigator.pushReplacementNamed(context, '/');
        },
        child: Text(
          "Zoe's Crochet",
          style: TextStyle(
            fontSize: isWeb ? 28 : 24,
            fontWeight: FontWeight.w300,
            letterSpacing: 2,
            color: const Color(0xFF8B7355),
          ),
        ),
      ),
      actions: isWeb ? _buildWebMenu(context) : null,
      iconTheme: const IconThemeData(color: Color(0xFF8B7355)),
    );
  }

  List<Widget> _buildWebMenu(BuildContext context) {
    return [
      _buildMenuItem(context, 'Inicio', '/'),
      _buildMenuItem(context, 'Catálogo', '/catalog'),
      _buildMenuItem(context, 'Nuestra Historia', '/about'),
      _buildMenuItem(context, 'Contáctanos', '/contact'),
      const SizedBox(width: 20),
    ];
  }

  Widget _buildMenuItem(BuildContext context, String title, String route) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    final isActive = currentRoute == route;

    return TextButton(
      onPressed: () {
        if (currentRoute != route) {
          Navigator.pushReplacementNamed(context, route);
        }
      },
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF8B7355),
        padding: const EdgeInsets.symmetric(horizontal: 20),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: isActive ? FontWeight.w500 : FontWeight.w300,
          letterSpacing: 1,
          decoration: isActive ? TextDecoration.underline : null,
          decorationColor: const Color(0xFF8B7355),
        ),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFFAF8F5),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFFF5EDE4),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.shopping_bag_outlined,
                  size: 60,
                  color: Color(0xFF8B7355),
                ),
                const SizedBox(height: 10),
                Text(
                  "Zoe's Crochet",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 2,
                    color: const Color(0xFF8B7355),
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.home_outlined,
            title: 'Inicio',
            route: '/',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.shopping_bag_outlined,
            title: 'Catálogo',
            route: '/catalog',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.info_outline,
            title: 'Nuestra Historia',
            route: '/about',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.contact_mail_outlined,
            title: 'Contáctanos',
            route: '/contact',
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String route,
  }) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    final isActive = currentRoute == route;

    return ListTile(
      leading: Icon(
        icon,
        color: isActive ? const Color(0xFF8B7355) : const Color(0xFFA89080),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: isActive ? FontWeight.w500 : FontWeight.w300,
          letterSpacing: 1,
          color: isActive ? const Color(0xFF8B7355) : const Color(0xFFA89080),
        ),
      ),
      selected: isActive,
      selectedTileColor: const Color(0xFFE8DED0).withOpacity(0.3),
      onTap: () {
        Navigator.pop(context);
        if (currentRoute != route) {
          Navigator.pushReplacementNamed(context, route);
        }
      },
    );
  }
}
