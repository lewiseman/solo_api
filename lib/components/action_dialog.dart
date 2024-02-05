import 'package:flutter/material.dart';

Future<T?> showActionDialog<T extends Object?>({
  required BuildContext context,
  required WidgetBuilder builder,
  RouteTransitionsBuilder transitionBuilder =
      SoloApiDialogRoute._defaultTransitionBuilder,
  Duration? transitionDuration,
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
  String? barrierLabel,
  Color? barrierColor = const Color(0x8A000000),
  bool barrierDismissible = false,
  bool dismissWithEsc = true,
}) {
  final themes = InheritedTheme.capture(
    from: context,
    to: Navigator.of(
      context,
      rootNavigator: useRootNavigator,
    ).context,
  );
  return Navigator.of(
    context,
    rootNavigator: useRootNavigator,
  ).push<T>(SoloApiDialogRoute<T>(
    context: context,
    builder: builder,
    barrierColor: barrierColor,
    barrierDismissible: barrierDismissible,
    barrierLabel: barrierLabel,
    dismissWithEsc: dismissWithEsc,
    settings: routeSettings,
    transitionBuilder: transitionBuilder,
    transitionDuration: transitionDuration ?? const Duration(milliseconds: 300),
    themes: themes,
  ));
}

class SoloApiDialogRoute<T> extends RawDialogRoute<T> {
  SoloApiDialogRoute({
    required WidgetBuilder builder,
    required BuildContext context,
    CapturedThemes? themes,
    super.barrierDismissible,
    super.barrierColor = const Color(0x8A000000),
    String? barrierLabel,
    super.transitionDuration,
    super.transitionBuilder = _defaultTransitionBuilder,
    super.settings,
    bool dismissWithEsc = true,
  }) : super(
            pageBuilder: (context, animation, secondaryAnimation) {
              final pageChild = Builder(builder: builder);
              final dialog = themes?.wrap(pageChild) ?? pageChild;
              return SafeArea(
                child: Actions(
                  actions: {
                    if (dismissWithEsc) DismissIntent: _DismissAction(context),
                  },
                  child: FocusScope(
                    autofocus: true,
                    child: dialog,
                  ),
                ),
              );
            },
            barrierLabel: barrierLabel);

  static Widget _defaultTransitionBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      ),
      child: ScaleTransition(
        scale: CurvedAnimation(
          parent: Tween<double>(
            begin: 1,
            end: 0.85,
          ).animate(animation),
          curve: Curves.easeOut,
        ),
        child: child,
      ),
    );
  }
}

class _DismissAction extends DismissAction {
  _DismissAction(this.context);

  final BuildContext context;

  @override
  void invoke(covariant DismissIntent intent) {
    Navigator.of(context).pop();
  }
}

const kDefaultContentDialogConstraints = BoxConstraints(
  maxWidth: 368.0,
  maxHeight: 756.0,
);

class ContentDialog extends StatelessWidget {
  /// Creates a content dialog.
  const ContentDialog({
    super.key,
    this.title,
    this.content,
    this.actions,
    this.constraints = kDefaultContentDialogConstraints,
  });

  /// The title of the dialog. Usually, a [Text] widget
  final Widget? title;

  /// The content of the dialog. Usually, a [Text] widget
  final Widget? content;

  /// The actions of the dialog. Usually, a List of [Button]s
  final List<Widget>? actions;

  /// The style used by this dialog. If non-null, it's merged with
  /// [FluentThemeData.dialogTheme]

  /// The constraints of the dialog. It defaults to `BoxConstraints(maxWidth: 368)`
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Align(
      alignment: AlignmentDirectional.center,
      child: Container(
        constraints: constraints,
        child: Material(
          borderRadius: BorderRadius.circular(12),
          elevation: 3,
          color: theme.canvasColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (title != null)
                        Padding(
                          padding: const EdgeInsetsDirectional.only(bottom: 12),
                          child: DefaultTextStyle.merge(
                              child: title!, style: theme.textTheme.titleLarge),
                        ),
                      if (content != null)
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.zero,
                            child: DefaultTextStyle.merge(
                              child: content!,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              if (actions != null)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(12),
                    ),
                  ),
                  child: () {
                    if (actions!.length == 1) {
                      return Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: actions!.first,
                      );
                    }
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: actions!.map((e) {
                        final index = actions!.indexOf(e);
                        return Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(
                              end: index != (actions!.length - 1) ? 10 : 0,
                            ),
                            child: e,
                          ),
                        );
                      }).toList(),
                    );
                  }(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
