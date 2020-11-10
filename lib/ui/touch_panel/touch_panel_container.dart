import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './touch_panel_widget.dart';
import '../../providers/app_provider.dart';
import '../../utils/helper.dart';

class TouchPanelContainer extends StatefulWidget {
  @override
  _TouchPanelContainerState createState() => _TouchPanelContainerState();
}

class _TouchPanelContainerState extends State<TouchPanelContainer>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation opacityAnimation;
  AppProvider appProvider;
  bool countProcessStarted8 = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 800,
        ));
    opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));
  }

  @override
  Widget build(BuildContext context) {
    appProvider = Provider.of<AppProvider>(context);
    appProvider.addListener(() async {
      if (appProvider.countProcessStarted) {
        countProcessStarted8 = await Helper.setValueAfterDelay(
            countProcessStarted8, appProvider.countProcessStarted, 1200);
        setState(() {
          controller.forward();
        });
      } else {
        countProcessStarted8 = await Helper.setValueAfterDelay(
            countProcessStarted8, appProvider.countProcessStarted, 0);
        setState(() {
          controller.reverse();
        });
      }
    });

    return Container(
      child: !countProcessStarted8
          ? null
          : FadeTransition(
              opacity: opacityAnimation,
              child: TouchPanelWidget(),
            ),
    );
  }
}
