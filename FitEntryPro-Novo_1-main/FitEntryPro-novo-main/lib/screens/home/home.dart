import 'package:flutter/material.dart';
import 'package:parking/repository/entradas_repository.dart';
import 'package:parking/screens/home/components/card_entradas.dart';
import 'package:parking/screens/home/components/principal_row.dart';
import 'package:parking/screens/shared/custom_appbar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

@override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('FitEntryPro', context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'nova_entrada');
        },
        child: const Icon(
          Icons.add
        ),
      ),
      body: buildScreen(),
    );
  }

  Widget buildScreen() {
    var listOfEntradas = [];
    return FutureBuilder(
      future: EntradasRepository.findAll(), 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.connectionState == ConnectionState.none) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Text('Não existem entradas cadastradas'),
              ),
              TextButton(
                onPressed: () async {
                  listOfEntradas = await EntradasRepository.findAll();
                  setState(() {});
                },
                child: const Text('Atualizar'),
              )
            ],
          );
        }
        listOfEntradas = snapshot.data!;
        return RefreshIndicator(
          onRefresh: () async{
            listOfEntradas = await EntradasRepository.findAll();
            setState(() {});
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const PrincipalRow(),
                const SizedBox(height: 24),
                 Expanded(
                  child: ListView.builder(
                    itemCount: listOfEntradas.length,
                    itemBuilder: (context, index) => CardEntradas(
                      entradas: listOfEntradas[index],
                    ),
                  ),
                ),
              ]
            ),
          ),
        );
      },
    );
  }
}