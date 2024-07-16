import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../design_tools/tool_widgets/app_colors.dart';
import '../design_tools/tool_widgets/necesary_images.dart';
import '../design_tools/tool_widgets/tool_widgets.dart';

class MyDrawer {
  static Widget buildDrawer(BuildContext context) {
    return Drawer(
      elevation: 20,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(70), bottomRight: Radius.circular(400)),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage(NecessaryImages.logo)),
              color: AppColors.paleWhite,
            ),
            child: AppWidgets.mainLogo(context, 20, 20),
          ),
          ListTile(
            leading: Icon(Icons.music_note),
            title: const Text('Eventos'),
            onTap: () {
              // Acción cuando se selecciona la opción Ensayos
              //Ir a siguiente página
              GoRouter.of(context).go('/concertsPage');
              ; // Cierra el Drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: const Text('Muro'),
            onTap: () {
              // Acción cuando se selecciona la opción Muro
              Navigator.pushNamed(context, '/wallPage'); // Cierra el Drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: const Text('Perfil'),
            onTap: () {
              // Acción cuando se selecciona la opción Perfil
              //Ir a siguiente página
              GoRouter.of(context).go('/profilePage');
              ;

              ; // Cierra el Drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.group),
            title: const Text('Integrantes'),
            onTap: () {
              // Acción cuando se selecciona la opción Integrantes
              Navigator.pop(context); // Cierra el Drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.group_work),
            title: const Text('Crew'),
            onTap: () {
              // Acción cuando se selecciona la opción Crew
              GoRouter.of(context).go('/crewPage');
              ; // Cierra el Drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.event),
            title: const Text('Disponibilidad'),
            onTap: () {
              // Acción cuando se selecciona la opción Disponibilidad
              Navigator.pop(context); // Cierra el Drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: const Text('Ayuda y Soporte'),
            onTap: () {
              // Acción cuando se selecciona la opción Ayuda y Soporte
              Navigator.pop(context); // Cierra el Drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: const Text('Cerrar Sesión'),
            onTap: () {
              // Acción cuando se selecciona la opción Cerrar Sesión
              Navigator.pop(context); // Cierra el Drawer
            },
          ),
        ],
      ),
    );
  }
}
