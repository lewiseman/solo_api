import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

class ResponseHeaderSect extends StatelessWidget {
  const ResponseHeaderSect({super.key, required this.headers});
  final Map<String, String> headers;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: PlutoGrid(
        mode: PlutoGridMode.readOnly,
        configuration: PlutoGridConfiguration(
          columnSize: const PlutoGridColumnSizeConfig(
            autoSizeMode: PlutoAutoSizeMode.equal,
            resizeMode: PlutoResizeMode.pushAndPull,
          ),
          style: PlutoGridStyleConfig(
            gridBackgroundColor: theme.canvasColor,
            borderColor: theme.dividerColor,
            rowColor: theme.canvasColor,
            gridBorderColor: theme.dividerColor,
            defaultColumnTitlePadding: const EdgeInsets.only(left: 10),
            defaultCellPadding: const EdgeInsets.only(left: 10),
            iconSize: 10,
            rowHeight: 28,
            columnHeight: 28,
          ),
        ),
        columns: [
          PlutoColumn(
            title: 'Key',
            field: 'key',
            type: PlutoColumnType.text(),
            readOnly: true,
            enableSorting: false,
            enableEditingMode: false,
            enableFilterMenuItem: false,
            enableContextMenu: false,
            enableColumnDrag: false,
          ),
          PlutoColumn(
            title: 'Value',
            field: 'value',
            type: PlutoColumnType.text(),
            readOnly: true,
            enableSorting: false,
            enableEditingMode: false,
            enableFilterMenuItem: false,
            enableContextMenu: false,
            enableColumnDrag: false,
            enableDropToResize: false,
          ),
        ],
        rows: headers.keys
            .map((e) => PlutoRow(
                  type: PlutoRowType.normal(),
                  cells: {
                    'key': PlutoCell(value: e),
                    'value': PlutoCell(value: headers[e]),
                  },
                ))
            .toList(),
        onChanged: (PlutoGridOnChangedEvent event) {},
        onLoaded: (PlutoGridOnLoadedEvent event) {},
      ),
    );
  }
}
