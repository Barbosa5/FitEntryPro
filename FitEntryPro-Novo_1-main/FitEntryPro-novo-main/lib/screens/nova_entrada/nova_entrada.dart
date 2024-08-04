import 'package:flutter/material.dart';
import 'package:parking/model/entradas.dart'; 
import 'package:parking/repository/entradas_repository.dart';
import 'package:parking/screens/shared/custom_appbar.dart';
import 'package:parking/utils/timeFormat.dart';

class NovaEntrada extends StatefulWidget{
  const NovaEntrada({super.key});

  @override
  State<NovaEntrada> createState() => _NovaEntradaState();
}

class _NovaEntradaState extends State<NovaEntrada> {
  final _formKey = GlobalKey<FormState>();
  final _entryTimeController = TextEditingController(
    text: fromTimeOfDay(TimeOfDay.now()),
  );
  final _selectedTime = TimeOfDay.now();
  final _nameController = TextEditingController();
  final _idadeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Nova entrada', context),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            save();
          }
        },
        child: const Icon(Icons.save),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nome',
                ),
                autofocus: true,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _idadeController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Idade',
                ),
                autofocus: true,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _entryTimeController,
                readOnly: true,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Horário da entrada',
                  suffixIcon: IconButton(
                    onPressed: () async {
                      _entryTimeController.text = await showCustomTimePicker();
                    },
                    icon: const Icon(
                      Icons.schedule,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> showCustomTimePicker() async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (selectedTime == null) {
      return fromTimeOfDay(TimeOfDay.now());
    }
    return fromTimeOfDay(selectedTime);
  }

  void save() async {
    try {
      final entrada = Entradas(
        idade: int.parse( _idadeController.text),
        name: _nameController.text,
        entryTime: _selectedTime,
      );
      final id = await EntradasRepository.insert(entrada);
      SnackBar snackBar;
      if (id != 0) {
        snackBar =
            SnackBar(content: Text('A Entrada $id foi salva com sucesso!!!'));
      } else {
        snackBar = const SnackBar(
          content:
              Text('Lamento, houve um problema ao tentar salvar a sua Entrada!!!'),
        );
      }
      // Exibir a SnackBar
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (error) {
      SnackBar snackBar = const SnackBar(
        content: Text('Ops. Tivemos um problema técnico!!!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}