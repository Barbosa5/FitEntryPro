import 'package:flutter/material.dart';
import 'package:parking/screens/home/home.dart';
import 'package:parking/screens/client_list/client_list.dart';
import 'package:parking/screens/nova_entrada/nova_entrada.dart';
import 'package:parking/screens/planos/planos.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home': (context) => const Home(),
        'client_list': (context) => const ClientList(),
        'planos': (context) => const Planos(),
        'nova_entrada': (context) => NovaEntrada()
      },
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.white, brightness: Brightness.dark)),
    ),
  );
}
