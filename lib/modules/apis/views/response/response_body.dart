import 'package:flutter/material.dart';
import 'package:flutter_json_view/flutter_json_view.dart';

class APIResponseBody extends StatelessWidget {
  const APIResponseBody({super.key, required this.body});
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return JsonView.string(
      body,
      theme: JsonViewTheme(
        backgroundColor: theme.canvasColor,
        closeIcon: Icon(
          Icons.arrow_drop_up,
          size: 18,
          color: theme.iconTheme.color,
        ),
        openIcon: Icon(
          Icons.arrow_drop_down,
          size: 18,
          color: theme.iconTheme.color,
        ),
      ),
    );
  }
}
