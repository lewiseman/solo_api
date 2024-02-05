import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:solo_api/common.dart';
import 'package:solo_api/modules/apis/views/response/response_body.dart';
import 'package:solo_api/modules/apis/views/response/response_header.dart';

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
            padding: const EdgeInsets.only(top: 5),
            child: TabBarView(
              controller: tabController,
              children: [
                if (routeData?.value?.body.isNotEmpty ?? false)
                APIResponseBody(body: routeData!.value!.body)
                else
                  const Center(child: Text('No Body')),
                if (routeData?.value?.headers.isNotEmpty ?? false)
                  ResponseHeaderSect(
                    headers: routeData!.value!.headers,
                  )
                else
                  const Center(child: Text('No Headers')),
                const Center(child: Text('No Cookies')),
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
