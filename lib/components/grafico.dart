import 'package:app_despesas/components/grafico_barras.dart';
import 'package:app_despesas/models/transacao.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Grafico extends StatelessWidget {
  final List<Transacao> transacoesRecentes;

  Grafico(this.transacoesRecentes);

  List<Map<String, Object>> get transacoesAgrupadas {
    return List.generate(7, (index){
      final diaSemana = DateTime.now().subtract(
        Duration(days: index),
      );

      double somaDia = 0.0;
      // double somaTotal = 0.0;

      for(var i = 0; i < transacoesRecentes.length; i++){
        bool mesmoDia = transacoesRecentes[i].date.day == diaSemana.day;
        bool mesmoMes = transacoesRecentes[i].date.month == diaSemana.month;
        bool mesmoAno = transacoesRecentes[i].date.year == diaSemana.year;

        if(mesmoDia && mesmoMes && mesmoAno){
          somaDia += transacoesRecentes[i].value;
        }
        // somaTotal += transacoesRecentes[i].value;
      }

      const Map siglaDiaSemana = {
        'Mon': 'Seg',
        'Thu': 'Ter',
        'Wed': 'Qua',
        'Tue': 'Qui',
        'Fri': 'Sex',
        'Sat': 'Sáb',
        'Sun': 'Dom',
      };

      return {
        'day': siglaDiaSemana[DateFormat.E().format(diaSemana)],
        'valor': somaDia,
        // 'porcentagem': somaDia / somaTotal
      };
    });
  }

  double get _valorTotalSemana {
    return transacoesAgrupadas.fold(0.0, (soma, tr) {
      return soma + (tr['valor'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    transacoesAgrupadas;
    return Card(
      color: Colors.white,
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: transacoesAgrupadas.map((tr){
            return Flexible(
              fit: FlexFit.tight,
              child: GraficoBarra(
                label: tr['day'].toString(),
                valor: tr['valor'] as double,
                percentual: _valorTotalSemana != 0 ? (tr['valor'] as double) / _valorTotalSemana : 0,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}