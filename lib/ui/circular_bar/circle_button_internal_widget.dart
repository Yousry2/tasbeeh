import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../custom_theme.dart';

class CircleButtonInternalWidget extends StatelessWidget {
  final String mainTxt;
  final String bottomTxt;
  final String topTxt;
  final bool countingModeStarted;

  CircleButtonInternalWidget({
    this.topTxt,
    this.bottomTxt,
    this.mainTxt,
    this.countingModeStarted,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 5),
            //  decoration: BoxDecoration(shape: BoxShape.circle),
            constraints: BoxConstraints(
              maxHeight: constraints.maxHeight * .8,
              //   minHeight: constraints.minHeight * .8
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  constraints: BoxConstraints(
                    maxHeight: constraints.maxHeight * .25,
                    //  minHeight: constraints.maxHeight * 0,
                  ),
                  alignment: Alignment.center,
                  width: 100,
                  // height: 46,
                  child: AutoSizeText(
                    topTxt,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                    style: CustomTheme.topLabelStyle.copyWith(fontSize: null),
                  ),
                ),
                Container(
                  constraints: BoxConstraints(
                    maxHeight: constraints.maxHeight * .6,
                    //   minHeight: constraints.maxHeight * .6
                  ),
                  child: AutoSizeText(
                    bottomTxt,
                    style: CustomTheme.bottomLabelStyle,
                    maxLines: 1,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
