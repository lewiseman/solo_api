import 'package:flutter/material.dart';
import 'package:solo_api/common.dart';
import 'package:solo_api/modules/apis/views/request/request_head.dart';
import 'package:solo_api/modules/apis/views/request/request_params.dart';

class APIRequest extends ConsumerWidget {
  const APIRequest({
    super.key,
    required this.route,
    required this.tabController,
    required this.tabs,
    required this.theme,
    required this.routeData,
    required this.onDelete,
  });

  final APIRoute route;
  final TabController tabController;
  final List<Text> tabs;
  final ThemeData theme;
  final AsyncValue? routeData;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: theme.dividerColor,
          ),
        ),
      ),
      child: Column(
        children: [
          APIRequestHead(
            key: ValueKey(route.id),
            route: route,
            theme: theme,
            routeData: routeData,
            onDelete: onDelete,
          ),
          TabBar(
            controller: tabController,
            isScrollable: true,
            tabAlignment: TabAlignment.startOffset,
            dividerColor: theme.dividerColor,
            labelPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            tabs: tabs,
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                RequestParams(
                  key: ValueKey(route.id),
                  route: route,
                ),
                Text('data'),
                Text('data'),
                Text('data'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
