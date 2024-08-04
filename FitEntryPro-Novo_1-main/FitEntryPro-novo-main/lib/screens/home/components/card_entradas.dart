import 'package:flutter/material.dart';
import 'package:parking/model/entradas.dart';
import 'package:parking/repository/entradas_repository.dart';

class CardEntradas extends StatelessWidget {
  final Entradas entradas;
  const CardEntradas({
    super.key,
    required this.entradas,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction) async {
        SnackBar snackBar;
        var result = await EntradasRepository.delete(entradas.number!);
        if (result != 0) {
          snackBar =
              const SnackBar(content: Text('Ticket removido com sucesso!!!'));
        } else {
          snackBar = const SnackBar(
              content: Text('Ops. Não foi possível remover o ticket!!!'));
        }
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        child: const Align(
          alignment: Alignment(.9, 0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      key: Key(entradas.number.toString()),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Icon(
                Icons.account_circle,
                size: 90,
              ),
              Container(
                width: 190,
                height: 110,
                padding: const EdgeInsets.symmetric(vertical: 2.0), // Espaço interno do container
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black, // Cor da borda
                    width: 2.0, // Largura da borda
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15.0), // Bordas arredondadas
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Nome:',
                            style: TextStyle(
                              fontSize: 8,
                            ),
                          ),
                          Text(
                            entradas.name,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Idade:',
                            style: TextStyle(
                              fontSize: 8,
                            ),
                          ),
                          Text(
                            entradas.idade.toString(),
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40
                      ),
                      Row(
                        children: [
                          const Text(
                            'Entrada:',
                            style: TextStyle(
                              fontSize: 8,
                            ),
                          ),
                          Text(
                            entradas.entryTime.toString(),
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
