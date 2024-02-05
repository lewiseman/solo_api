import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:solo_api/common.dart';
import 'package:solo_api/modules/apis/views/request_sect.dart';
import 'package:solo_api/modules/apis/views/response_sect.dart';

class APIRouteBody extends StatefulWidget {
  const APIRouteBody({
    super.key,
    required this.route,
    required this.theme,
    required this.routeData,
  });
  final APIRoute route;
  final ThemeData theme;
  final AsyncValue<Response>? routeData;

  @override
  State<APIRouteBody> createState() => _APIRouteBodyState();
}

class _APIRouteBodyState extends State<APIRouteBody>
    with TickerProviderStateMixin {
  late final TabController requestTabController = TabController(
    length: 4,
    vsync: this,
  );
  late final TabController responseTabController = TabController(
    length: 3,
    vsync: this,
  );

  final requestTabs = const [
    Text('Params'),
    Text('Authorization'),
    Text('Headers'),
    Text('Body'),
  ];

  final responseTabs = const [
    Text('Body'),
    Text('Headers'),
    Text('Cookies'),
  ];

  @override
  Widget build(BuildContext context) {
    return Split(
      axis: Axis.vertical,
      initialFractions: const [.7, .3],
      children: [
        APIRequest(
          route: widget.route,
          tabController: requestTabController,
          tabs: requestTabs,
          theme: widget.theme,
          routeData: widget.routeData,
        ),
        APIResponse(
          tabController: responseTabController,
          tabs: responseTabs,
          theme: widget.theme,
          routeData: widget.routeData,
        )
      ],
    );
  }
}
