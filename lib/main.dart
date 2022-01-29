import 'package:app_despesas/models/transacao.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

main() => runApp(const DespesasApp());

class DespesasApp extends StatelessWidget {
  const DespesasApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final titleCotroller = TextEditingController();
  final valueCotroller = TextEditingController();
  

  final _transacoes = [
    Transacao(
      id: 't1',
      title: 'Computador',
      value: 200.00,
      date: DateTime.now()
    ),
    Transacao(
      id: 't2',
      title: 'Celular',
      value: 532.40,
      date: DateTime.now()
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesas pessoais'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Card(
            color: Colors.blue,
            child: Text('Gráfico'),
            elevation: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _transacoes.map((tr){
              return Card(
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.purple,
                          width: 2,
                        ),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'R\$ ${tr.value.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          tr.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          DateFormat('d/MM/y').format(tr.date),
                          style: const TextStyle(
                            color: Colors.grey
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  TextField(
                    // onChanged: (valor) => title = valor,
                    controller: titleCotroller,
                    decoration: const InputDecoration(
                      labelText: 'Título',
                    ),
                  ),
                  TextField(
                    // onChanged: (valor) => value = valor,
                    controller: valueCotroller,
                    decoration: const InputDecoration(
                      labelText: 'Valor',
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      foregroundColor: MaterialStateProperty.all(Colors.purple),
                    ),
                    child: const Text('Nova transação'),
                    onPressed: () {
                      print(titleCotroller.text);
                      print(valueCotroller.text);
                    },
                  )
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}
