import 'package:flutter/material.dart';
import 'package:solo_api/common.dart';

class RequestParams extends ConsumerStatefulWidget {
  const RequestParams({super.key, required this.route});
  final APIRoute route;

  @override
  ConsumerState<RequestParams> createState() => _RequestParamsState();
}

class _RequestParamsState extends ConsumerState<RequestParams> {
  List<Map<String, TextEditingController>> fields = [];
  Map<String, String>? oldParams;

  @override
  void initState() {
    super.initState();
    widget.route.changes.listen(checkParamsChanges);
    fields = getParams(widget.route);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Table(
            columnWidths: const {
              0: IntrinsicColumnWidth(),
            },
            border: TableBorder.all(
              borderRadius: BorderRadius.circular(3),
            ),
            children: [
              TableRow(
                children: [
                  TableCell(
                    child: Checkbox(
                      value: false,
                      splashRadius: 10,
                      onChanged: (bool? value) {},
                    ),
                  ),
                  const TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                        'Key',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                        'Value',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              ...fields.map(
                (e) => TableRow(
                  children: [
                    TableCell(
                      child: Checkbox(
                        value: false,
                        splashRadius: 10,
                        onChanged: (bool? value) {},
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: TextField(
                          controller: e['key'],
                          onChanged: (value) {
                            updateParam(e['key']!.text, value);
                          },
                          decoration: const InputDecoration.collapsed(
                            hintText: 'Key',
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: TextField(
                          controller: e['value'],
                          decoration: const InputDecoration.collapsed(
                            hintText: 'Value',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  updateParam(String key, String value) {
    final realm = ref.read(realmProvider);
    print(key);
    print(value);
  }

  void checkParamsChanges(RealmObjectChanges<APIRoute> newRoute) {
    if (oldParams != null) {
      final newParams =
          Uri.tryParse(newRoute.object.url ?? '')?.queryParameters;
      if (newParams != oldParams) {
        final newFields = getParams(newRoute.object);
        setState(() {
          fields = newFields;
        });
      }
    }
  }

  List<Map<String, TextEditingController>> getParams(APIRoute route) {
    try {
      final uri = Uri.parse(route.url!);
      oldParams = uri.queryParameters;
      return oldParams!.keys
          .map((e) => {
                'key': TextEditingController(text: e),
                'value': TextEditingController(text: oldParams![e])
              })
          .toList();
    } catch (e) {
      return [];
    }
  }
}
