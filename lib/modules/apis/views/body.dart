import 'package:flutter/material.dart';
import 'package:solo_api/common.dart';

class APIRouteBody extends StatelessWidget {
  const APIRouteBody({
    super.key,
    required this.route,
    required this.theme,
  });
  final APIRoute route;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            route.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Material(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(6),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: theme.dividerColor,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: theme.dividerColor,
                              ),
                            ),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(6),
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Row(
                                children: [
                                  Text('GET'),
                                  Icon(Icons.keyboard_arrow_down_rounded)
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(route.name),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 6),
              FilledButton(
                onPressed: () {},
                child: Text('Send'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
