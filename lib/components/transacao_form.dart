import 'package:app_despesas/models/transacao.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransacaoForm extends StatefulWidget{

  void Function(String, double, DateTime) novaTransacao;

  TransacaoForm(this.novaTransacao);

  @override
  State<TransacaoForm> createState() => _TransacaoFormState();
}

class _TransacaoFormState extends State<TransacaoForm> {
  final titleCotroller = TextEditingController();
  final valueCotroller = TextEditingController();
  final dateCotroller = TextEditingController(
    // text: DateFormat('dd/MM/yyyy').format(DateTime.now())
  );

  _submit() {
    final title = titleCotroller.text;
    final value = double.tryParse(valueCotroller.text) ?? 0.0;
    final date = dateCotroller.text;
    
    int ano = int.tryParse(dateCotroller.text.split('/')[2]) ?? DateTime.now().year;
    int mes = int.tryParse(dateCotroller.text.split('/')[1]) ?? DateTime.now().month;
    int dia = int.tryParse(dateCotroller.text.split('/')[0]) ?? DateTime.now().day;

    final data = DateTime(ano, mes, dia);

    if(title.isNotEmpty && value >= 0.0 && valueCotroller.text.isNotEmpty && date.isNotEmpty){
      widget.novaTransacao(title, value, data);
    }
    else{
      return;
    }    
  }

  @override
  Widget build(BuildContext context){
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              // onChanged: (valor) => title = valor,
              controller: titleCotroller,
              onSubmitted: (_) => _submit(),
              decoration: const InputDecoration(
                labelText: 'Título',
              ),
            ),
            TextField(
              // onChanged: (valor) => value = valor,
              controller: valueCotroller,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              // keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submit(),
              decoration: const InputDecoration(
                labelText: 'Valor',
              ),
            ),
            TextField(
              // onChanged: (valor) => value = valor,
              controller: dateCotroller,
              maxLength: 10,
              keyboardType: TextInputType.datetime,
              // keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submit(),
              decoration: const InputDecoration(
                labelText: 'Data',
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                foregroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.secondary),
              ),
              child: const Text('Nova transação'),
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}