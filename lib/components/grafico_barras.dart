import 'package:flutter/material.dart';

class GraficoBarra extends StatelessWidget {

  final String label;
  final double valor;
  final double percentual;

  GraficoBarra({
    required this.label,
    required this.valor,
    required this.percentual,
  });

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        FittedBox(
          child: Text(valor.toStringAsFixed(2))
        ),
        const SizedBox(height: 5),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  color: const Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              FractionallySizedBox(
                heightFactor: percentual,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 5),
        Text(label),
      ],
    );
  }
}
