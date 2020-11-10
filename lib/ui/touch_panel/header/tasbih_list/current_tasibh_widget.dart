import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../custom_theme.dart';
import '../../../../models/tasbih.dart';
import '../../../../providers/tasbih_daily_list_provider.dart';

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
        // padding: EdgeInsets.symmetric(vertical: 2),
        height: 50,
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
          borderRadius: BorderRadius.circular(10),
          color: this.tasbih.id == tasbihDailyListProvider.choosenTasbihId
              ? CustomTheme.bgColor2
              : Colors.transparent,
        ),
        child: ch,
      ),
      child: ListTile(
        //dense: true,
        // contentPadding: EdgeInsets.only(bottom: 10),
        title: Text(
          tasbih.name,
          style: TextStyle(color: CustomTheme.infoTxtColor),
        ),

        trailing: Container(
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Chip(
                  backgroundColor: done
                      ? CustomTheme.doneColor
                      : tasbih.numberOfGroupsDoneToday < 1
                          ? CustomTheme.inProgressColor
                          : CustomTheme.startColor,
                  label: Text(
                      '${tasbih.numberOfGroupsDoneToday.toString()} / ${tasbih.numberOfDailyGroups.toString()}')
                  // label: CircleAvatar(
                  //   radius: 12,
                  //   child: Icon(
                  //     Icons.done,
                  //     // size: 16,
                  //     color: CustomTheme.mainTxtColor,
                  //   ),
                  // ),
                  ),
              Icon(
                Icons.menu,
                size: 28,
                color: CustomTheme.bgColor1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
