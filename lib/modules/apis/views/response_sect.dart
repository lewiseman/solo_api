import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:solo_api/common.dart';

class APIResponse extends StatelessWidget {
  const APIResponse({
    super.key,
    required this.tabController,
    required this.tabs,
    required this.theme,
    this.routeData,
  });
  final TabController tabController;
  final List<Text> tabs;
  final ThemeData theme;
  final AsyncValue<Response>? routeData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          dividerColor: Colors.transparent,
          labelPadding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          tabs: tabs,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 5, left: 12),
            child: TabBarView(
              controller: tabController,
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.only(right: 12),
                  child: Text(
                    routeData?.value?.body ?? '',
                  ),
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.only(right: 12),
                  child: Text(
                    routeData?.value?.headers.toString() ?? '',
                  ),
                ),
                Text('No cookies'),
              ],
            ),
          ),
        ),
        if (routeData?.hasValue ?? false)
          Align(
            alignment: Alignment.centerRight,
            child: Wrap(
              spacing: 10,
              children: [
                Text.rich(
                  TextSpan(
                    text: 'Status : ',
                    children: [
                      TextSpan(
                        text:
                            '${routeData?.value?.statusCode} ${routeData?.value?.reasonPhrase}',
                      ),
                    ],
                  ),
                ),
                const Text.rich(
                  TextSpan(
                    text: 'Time : ',
                    children: [
                      TextSpan(text: '3.79 s'),
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    text: 'Size : ',
                    children: [
                      TextSpan(text: '${routeData?.value?.contentLength} B'),
                    ],
                  ),
                ),
                const SizedBox(width: 8)
              ],
            ),
          )
      ],
    );
  }
}
