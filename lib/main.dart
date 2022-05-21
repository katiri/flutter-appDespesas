import 'package:app_despesas/components/transacao_form.dart';
import 'package:flutter/material.dart';

import 'components/transacao_list.dart';
import 'components/grafico.dart';
import 'models/transacao.dart';

main() => runApp(const DespesasApp());

class DespesasApp extends StatelessWidget {
  const DespesasApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();
 
    return MaterialApp(
      home: HomePage(),
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: Colors.red,
          secondary: Colors.amber,
        ),
        textTheme: tema.textTheme.copyWith(
          headline6: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
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
    //   id: 't0',
    //   title: 'Televisão',
    //   value: 900.00,
    //   date: DateTime.now().subtract(Duration(days: 33)),
    // ),
    // Transacao(
    //   id: 't1',
    //   title: 'Computador',
    //   value: 200.00,
    //   date: DateTime.now().subtract(Duration(days: 3)),
    // ),
    // Transacao(
    //   id: 't2',
    //   title: 'Celular',
    //   value: 532.40,
    //   date: DateTime.now().subtract(Duration(days: 2)),
    // ),
  ];

  List<Transacao> get _transacoesRecentes {
    return _transacoes.where((tr){
      return tr.date.isAfter(DateTime.now().subtract(
        const Duration(days: 7),
      ));
    }).toList();
  }
  
  void _novaTransacao(String titulo, double valor, DateTime data){
    setState(() {
      _transacoes.add(
        Transacao(
          id: 't${_transacoes.length + 1}',
          title: titulo,
          value: valor,
          date: data
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
        title: Text('Despesas pessoais'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _openTransacaoForm(context),
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Grafico(_transacoesRecentes),
            // Card(
            //   color: Theme.of(context).colorScheme.primary,
            //   child: Text('Gráfico'),
            //   elevation: 5,
            // ),
            TransacaoList(_transacoes),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        onPressed: () => _openTransacaoForm(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
