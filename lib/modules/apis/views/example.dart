import 'package:flutter/material.dart';
import 'package:solo_api/common.dart';

class SlitExample extends StatelessWidget {
  const SlitExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Split(
        axis: Axis.horizontal,
        splitters: [
          SizedBox(
            width: 6,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).dividerColor,
              ),
            ),
          ),
        ],
        initialFractions: [.3, .7],
        children: [Text('data'), Text('data2 2 ')],
      ),
    );
  }
}
