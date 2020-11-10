import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './sleek_slider_widget.dart';
import '../../custom_theme.dart';
import '../../providers/app_provider.dart';
import '../../providers/tasbih_daily_list_provider.dart';

class CircleButtonWidget extends StatefulWidget {
  @override
  _CircleButtonWidgetState createState() => _CircleButtonWidgetState();
}

class _CircleButtonWidgetState extends State<CircleButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return
        //AnimatedBuilder(animation: null,builder: (context, child)=>
        GestureDetector(
      onTap: () {
        Provider.of<AppProvider>(context, listen: false).toggleCountProcess();
      },
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                // width: MediaQuery.of(context).size.width * 0.5,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: CustomTheme.curveGradient,
                  shape: BoxShape.circle,
                ),
                // child: Container(
                //   //  alignment: Alignment.center,
                //   decoration: BoxDecoration(
                //     shape: BoxShape.circle,
                //     color: CustomTheme.bgColor,
                //   ),
                //   height: 170,
                //   width: 170,
                child: Consumer<AppProvider>(
                  builder: (context, appProvider, ch) =>
                      Consumer<TasbihDailyListProvider>(
                          builder: (context, tasbihDailyListProvider, ch) {
                    print(
                        'qqqqqqqqqqqqqqqqqqqq${tasbihDailyListProvider.choosenTasbih}');
                    return SleekButtonWidget(
                      tasbih: tasbihDailyListProvider.choosenTasbih,
                      countingModeStarted: appProvider.countProcessStarted,
                    );
                  }),
                ),
                //),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
