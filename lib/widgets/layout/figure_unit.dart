import 'package:flutter/material.dart';

class FigureUnit extends StatelessWidget {
  final int value;
  final String unit;

  const FigureUnit({this.value, this.unit});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$value',
          style: Theme.of(context).textTheme.headline5,
        ),
        const SizedBox(width: 2),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 2),
            Text(
              unit,
              style: Theme.of(context).textTheme.subtitle2,
            )
          ],
        ),
      ],
    );
  }
}