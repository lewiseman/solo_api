import 'package:flutter/material.dart';
import 'package:solo_api/common.dart';

class RequestParams extends ConsumerStatefulWidget {
  const RequestParams({super.key, required this.route});
  final APIRoute route;

  @override
  ConsumerState<RequestParams> createState() => _RequestParamsState();
}

class _RequestParamsState extends ConsumerState<RequestParams> {
  List<Map<String, String?>> fields = [];
  Map<String, String>? oldParams;

  @override
  void initState() {
    super.initState();
    widget.route.changes.listen(checkParamsChanges);
    fields = getParams(widget.route);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
              color: theme.dividerColor,
            ),
            children: [
              TableRow(
                children: [
                  TableCell(
                    child: Checkbox(
                      value: fields.isNotEmpty,
                      side: BorderSide(color: theme.dividerColor),
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
                        side: BorderSide(color: theme.dividerColor),
                        splashRadius: 10,
                        onChanged: (bool? value) {},
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: TextField(
                          controller: TextEditingController()
                            ..text = e['key'] ?? ''
                            ..selection = TextSelection.collapsed(
                              offset: (e['key'] ?? '').length,
                            ),
                          onChanged: (value) {
                            updateParam(key: e['key'], value: value);
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
                          controller: TextEditingController()
                            ..text = e['value'] ?? ''
                            ..selection = TextSelection.collapsed(
                              offset: (e['value'] ?? '').length,
                            ),
                          onChanged: (value) {
                            updateParam(
                              key: e['value'],
                              value: value,
                              isKey: false,
                            );
                          },
                          decoration: const InputDecoration.collapsed(
                            hintText: 'Value',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TableRow(
                children: [
                  TableCell(
                    child: Checkbox(
                      value: false,
                      splashRadius: 10,
                      side: BorderSide(color: theme.dividerColor),
                      onChanged: (bool? value) {},
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: TextField(
                        onChanged: (value) {
                          addParam(value: value);
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
                        onChanged: (value) {},
                        decoration: const InputDecoration.collapsed(
                          hintText: 'Value',
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  void addParam({bool isKey = true, required String value}) {}

  void updateParam({String? key, required String value, bool isKey = true}) {
    // find the item that has changed using the key , which is the previous value .
    //Then update the value ( which is theincoming change)

    final itemIndex =
        fields.indexWhere((element) => element[isKey ? 'key' : 'value'] == key);
    if (itemIndex != -1) {
      final item = fields[itemIndex];

      setState(() {
        fields[itemIndex] = {
          'key': isKey ? value : item['key'],
          'value': isKey ? item['value'] : value
        };
      });
      // Update APIRoute url
      final uri = Uri.tryParse(widget.route.url ?? '');
      final newParams =
          fields.map((e) => MapEntry(e['key'] ?? '', e['value'] ?? ''));
      final newUrl = uri?.replace(queryParameters: Map.fromEntries(newParams));
      final newurlStr = newUrl?.toString() ?? '';
      final realm = ref.read(realmProvider);
      realm.write(() {
        widget.route.url = newurlStr;
      });
    }
  }

  void checkParamsChanges(RealmObjectChanges<APIRoute> newRouteObject) {
    if (newRouteObject.properties.contains('url')) {
      final newFields = getParams(newRouteObject.object);
      if (fields.toString() != newFields.toString()) {
        setState(() {
          fields = newFields;
        });
      }
    }
  }

  List<Map<String, String?>> getParams(APIRoute route) {
    try {
      final uri = Uri.parse(route.url!);
      oldParams = uri.queryParameters;
      return oldParams!.keys
          .map((e) => {'key': e, 'value': oldParams![e]})
          .toList();
    } catch (e) {
      return [];
    }
  }
}
