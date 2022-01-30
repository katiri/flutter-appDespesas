import 'package:app_despesas/components/transacao_form.dart';
import 'package:flutter/material.dart';

import 'components/transacao_list.dart';
import 'models/transacao.dart';

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

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);  

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transacao> _transacoes = [
    // Transacao(
    //   id: 't1',
    //   title: 'Computador',
    //   value: 200.00,
    //   date: DateTime.now()
    // ),
    // Transacao(
    //   id: 't2',
    //   title: 'Celular',
    //   value: 532.40,
    //   date: DateTime.now()
    // ),
  ];
  
  void _novaTransacao(String titulo, double valor){
    setState(() {
      _transacoes.add(
        Transacao(
          id: 't${_transacoes.length + 1}',
          title: titulo,
          value: valor,
          date: DateTime.now()
        ),
      );
    });

    Navigator.of(context).pop();
  }

  _openTransacaoForm(BuildContext context){
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransacaoForm(_novaTransacao);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesas pessoais'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _openTransacaoForm(context),
          ),
        ],
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Card(
              color: Colors.blue,
              child: Text('Gráfico'),
              elevation: 5,
            ),
            TransacaoList(_transacoes),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.purple,
        onPressed: () => _openTransacaoForm(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
