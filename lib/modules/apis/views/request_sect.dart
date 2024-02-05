import 'package:flutter/material.dart';
import 'package:solo_api/common.dart';
import 'package:solo_api/modules/apis/services/request_srv.dart';

class APIRequest extends ConsumerWidget {
  const APIRequest({
    super.key,
    required this.route,
    required this.tabController,
    required this.tabs,
    required this.theme,
    required this.routeData,
  });

  final APIRoute route;
  final TabController tabController;
  final List<Text> tabs;
  final ThemeData theme;
  final AsyncValue? routeData;

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
          Padding(
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
                                  borderRadius: const BorderRadius.horizontal(
                                    left: Radius.circular(6),
                                  ),
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
                    const SizedBox(width: 6),
                    FilledButton(
                      onPressed: routeData.runtimeType == AsyncLoading
                          ? null
                          : () {
                              ref
                                  .read(apiRequestServiceProvider.notifier)
                                  .sendRequest(route);
                            },
                      child: routeData.runtimeType == AsyncLoading
                          ? const SizedBox(
                              height: 15,
                              width: 15,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : const Text('Send'),
                    )
                  ],
                ),
              ],
            ),
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
        ],
      ),
    );
  }
}
