import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../custom_theme.dart';
import '../../models/tasbih.dart';
import '../../providers/tasbih_daily_list_provider.dart';

class CurrentTasbihWidget extends StatelessWidget {
  final Tasbih tasbih;

  CurrentTasbihWidget(this.tasbih);
  @override
  Widget build(BuildContext context) {
    final done = tasbih.numberOfDailyGroups <= tasbih.numberOfGroupsDoneToday;
    final ingrogress =
        tasbih.numberOfDailyGroups > tasbih.numberOfGroupsDoneToday &&
            tasbih.numberOfGroupsDoneToday != 0;
    final notstarted =
        tasbih.numberOfGroupsDoneToday == 0 && tasbih.numberOfDailyGroups != 0;
    return Consumer(
      builder: (ctx, TasbihDailyListProvider tasbihDailyListProvider, ch) =>
          Container(
        // alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20),

        height: 45,
        margin: EdgeInsets.symmetric(
          vertical: 5,
        ),
        //padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
          border: Border.all(
            color: CustomTheme.bgColor1,
            style: BorderStyle.solid,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(15),
          color: this.tasbih.id == tasbihDailyListProvider?.choosenTasbih?.id
              ? CustomTheme.bgColor2
              : Colors.transparent,
        ),
        child: ch,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          //dense: true,
          // contentPadding: EdgeInsets.only(bottom: 20),

          Expanded(
            child: Text(
              tasbih.name,
              overflow: TextOverflow.ellipsis,
              style: CustomTheme.currentTasbihInfoStyle,
            ),
          ),

          Container(
            width: 90,
            margin: EdgeInsets.only(left: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 25,
                  child: Chip(
                      padding: EdgeInsets.only(bottom: 8),
                      backgroundColor: done
                          ? CustomTheme.doneColor1
                          : tasbih.numberOfGroupsDoneToday < 1
                              ? CustomTheme.notYetStarted
                              : CustomTheme.inProgressColor,
                      label: Text(
                        '${tasbih.numberOfGroupsDoneToday.toString()} / ${tasbih.numberOfDailyGroups.toString()}',
                        style: CustomTheme.chipTxtStyle,
                      )
                      // label: CircleAvatar(
                      //   radius: 12,
                      //   child: Icon(
                      //     Icons.done,
                      //     // size: 16,
                      //     color: CustomTheme.mainTxtColor,
                      //   ),
                      // ),
                      ),
                ),
                Icon(
                  Icons.menu,
                  size: 28,
                  color: CustomTheme.bgColor1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
