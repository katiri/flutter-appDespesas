import 'package:app_despesas/models/transacao.dart';
import 'package:flutter/material.dart';

class TransacaoForm extends StatefulWidget{

  void Function(String, double) novaTransacao;

  TransacaoForm(this.novaTransacao);

  @override
  State<TransacaoForm> createState() => _TransacaoFormState();
}

class _TransacaoFormState extends State<TransacaoForm> {
  final titleCotroller = TextEditingController();
  final valueCotroller = TextEditingController();

  _submit() {
    final title = titleCotroller.text;
    final value = double.tryParse(valueCotroller.text) ?? 0.0;

    if(title.isNotEmpty && value >= 0.0 && valueCotroller.text.isNotEmpty){
      widget.novaTransacao(title, value);
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
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submit(),
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
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}