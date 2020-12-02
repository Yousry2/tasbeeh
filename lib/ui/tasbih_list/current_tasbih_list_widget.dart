import 'package:flutter/material.dart';
import 'package:misbaha_app/ui/tasbih_list/new_tasbih.dart';
import 'package:provider/provider.dart';

import './current_tasibh_widget.dart';
import '../../custom_theme.dart';
import '../../models/tasbih.dart';
import '../../providers/app_provider.dart';
import '../../providers/tasbih_daily_list_provider.dart';
import '../../utils/animated_opacity_widget.dart';
import '../../utils/helper.dart';

class CurrentTasbihList extends StatefulWidget {
  @override
  _CurrentTasbihListState createState() => _CurrentTasbihListState();
}

class _CurrentTasbihListState extends State<CurrentTasbihList> {
  AppProvider appProvider;
  TasbihDailyListProvider tasbihDailyListProvider;
  bool countProcessStarted2 = false;
  bool countProcessStarted6 = false;
  Tasbih deletedTasbih;

  Function deleteTasbih() {
    Navigator.of(context).pop();
    bool result = Provider.of<TasbihDailyListProvider>(context, listen: false)
        .removeTasbih(deletedTasbih);
    if (result) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Tasbih has been deleted successfully."),
      ));
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Error while deleting tasbih."),
      ));
    }
  }

  AlertDialog alert;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Widget deleteButton = FlatButton(
      child: Text("Delete"),
      onPressed: () {
        deleteTasbih();

        /// Navigator.of(context).pop();
      },
    );
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    alert = AlertDialog(
      titleTextStyle: CustomTheme.topLabelStyle,
      contentTextStyle: CustomTheme.topLabelStyle,
      backgroundColor: CustomTheme.bgColor,
      title: Text("Delete"),
      content: Text("Are you sure you want to delete this tasbih?"),
      actions: [
        cancelButton,
        deleteButton,
      ],
    );
  }

  startAddingNewTasbih(BuildContext ctx, Tasbih tasbih) {
    showModalBottomSheet(
        context: ctx,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              child: NewTasbih(
                tasbih: tasbih,
                addOrUpdateTasbih: addOrUpdateTasbih,
              ),
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
            ),
          );
        });
  }

  bool addOrUpdateTasbih(Tasbih tasbih) {
    if (tasbih.id == 0 || tasbih.id == null) {
      return this._addTasbih(tasbih);
    } else
      return this._updateTasbih(tasbih);
  }

  bool _addTasbih(tasbih) {
    bool result = Provider.of<TasbihDailyListProvider>(context, listen: false)
        .addTasbih(tasbih);
    if (result) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Tasbih has been added successfully."),
      ));
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Error while adding tasbih."),
      ));
    }
    return result;
  }

  _updateTasbih(tasbih) {
    bool result = Provider.of<TasbihDailyListProvider>(context, listen: false)
        .updateTasbih(tasbih);
    if (result) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Tasbih has been updated successfully."),
      ));
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Error while updating tasbih."),
      ));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    appProvider = Provider.of<AppProvider>(context);
    appProvider.addListener(() async {
      if (appProvider.countProcessStarted) {
        countProcessStarted2 = await Helper.setValueAfterDelay(
            countProcessStarted2, appProvider.countProcessStarted, 200);
        setState(() {});
        countProcessStarted6 = await Helper.setValueAfterDelay(
            countProcessStarted6, appProvider.countProcessStarted, 200);

        setState(() {});
      } else {
        countProcessStarted6 = await Helper.setValueAfterDelay(
            countProcessStarted6, appProvider.countProcessStarted, 200);
        setState(() {});
        countProcessStarted2 = await Helper.setValueAfterDelay(
            countProcessStarted2, appProvider.countProcessStarted, 200);
        setState(() {});
      }
    });

    return Container(
      child: LayoutBuilder(
        builder: (context, constraints) => Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            constraints.maxHeight < CustomTheme.CompactDeviceListHeight
                ? FittedBox()
                : AnimatedOpacityWidget(
                    direction: Directions.bottom,
                    showCondition: !countProcessStarted6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(width: 32.0, height: 0.0),
                        Text(
                          'My daily Tasbih List: ',
                          textAlign: TextAlign.start,
                          style: CustomTheme.currentTasbihHeaderTxtStyle,
                        ),
                        IconButton(
                          onPressed: () => startAddingNewTasbih(context, null),
                          icon: Icon(
                            Icons.add,
                            color: CustomTheme.mainTxtColor,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
            AnimatedOpacityWidget(
              direction: Directions.bottom,
              showCondition: !countProcessStarted2,
              child: Consumer<TasbihDailyListProvider>(
                builder: (context, tasbihDailyListProvider, ch) => Container(
                  // constraints:
                  //     BoxConstraints(maxHeight: constraints.maxHeight * 1),
                  height: constraints.maxHeight * .80,
                  // width: MediaQuery.of(context).size.width * .85,
                  child: tasbihDailyListProvider.userTasbihList == null
                      ? null
                      :
                      //  ListView.builder(
                      //     itemCount: tasbihDailyListProvider.userTasbihList !=
                      //             null
                      //         ? tasbihDailyListProvider.userTasbihList.length
                      //         : 0,
                      //     itemBuilder: (ctx, i) => CurrentTasbihWidget(
                      //         tasbihDailyListProvider.userTasbihList[i]),
                      //   ),

                      Theme(
                          data: Theme.of(context)
                              .copyWith(canvasColor: Colors.transparent),
                          child: Container(
                            child: ReorderableListView(
                              children: <Widget>[
                                ...tasbihDailyListProvider.userTasbihList
                                    .map((element) {
                                  return Dismissible(
                                    direction: DismissDirection.endToStart,
                                    key: UniqueKey(),
                                    background: Container(
                                      alignment: Alignment.centerRight,
                                      child: Icon(
                                        Icons.delete,
                                        size: 26,
                                        color: CustomTheme.color1,
                                      ),
                                    ),
                                    onDismissed: (direction) {
                                      setState(() {
                                        deletedTasbih = element;
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return alert;
                                          },
                                        );
                                      });
                                    },
                                    child: InkWell(
                                      onTap: () => tasbihDailyListProvider
                                          .selectTasbih(element),
                                      onDoubleTap: () => startAddingNewTasbih(
                                          context, element),
                                      child: Container(
                                          child: CurrentTasbihWidget(element)),
                                    ),
                                  );
                                })
                              ],
                              onReorder: (n, m) =>
                                  tasbihDailyListProvider.reorder(n, m),
                            ),
                          ),
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
