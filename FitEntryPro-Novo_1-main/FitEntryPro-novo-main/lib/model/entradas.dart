import 'package:flutter/material.dart';
import 'package:parking/utils/timeFormat.dart';

class Entradas{
  int? number;
  int idade;
  String name;
  TimeOfDay entryTime;

  Entradas({
    this.number,
    required this.idade,
    required this.name,
    required this.entryTime,
  });

  Map<String, Object?> toMap() => {
    'number' : number,
    'idade' : idade,
    'name' : name,
    'entryTime' : fromTimeOfDay(entryTime),
  };

  factory Entradas.fromMap(Map<String, Object?> map) => Entradas(
    number : map['number'] as int,
    idade: map['idade'] as int,
    name: map['name'] as String,
    entryTime: toTimeOfDay(map['entryTime'] as String),
  );
}