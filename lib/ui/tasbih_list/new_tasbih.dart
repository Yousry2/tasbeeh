import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:misbaha_app/custom_theme.dart';
import 'package:misbaha_app/models/tasbih.dart';

class NewTasbih extends StatefulWidget {
  @override
  _NewTasbihState createState() => _NewTasbihState();

  final Function addOrUpdateTasbih;
  Tasbih tasbih;

  NewTasbih({this.tasbih, this.addOrUpdateTasbih}) {
    if (this.tasbih == null) {
      this.tasbih = Tasbih(numberOfDailyGroups: 5, numberOfTasbihPerGroup: 33);
    }
  }
}

class _NewTasbihState extends State<NewTasbih>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final tasbihNameController = new TextEditingController();
  final numberOfDailyGroupsController = new TextEditingController();
  final numberOfTasbihPerGroupController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    tasbihNameController.text = widget.tasbih.name;
    numberOfDailyGroupsController.text =
        widget.tasbih.numberOfDailyGroups.toString();

    numberOfTasbihPerGroupController.text =
        widget.tasbih.numberOfTasbihPerGroup.toString();
  }

  void submitData() {
    if (this._formKey.currentState.validate()) {
      final enteredName = tasbihNameController.text;
      final enteredNumberOfDailyGroups =
          int.parse(numberOfDailyGroupsController.text, onError: (value) => 0);
      final enteredNumberOfTasbihPerGroup = int.parse(
          numberOfTasbihPerGroupController.text,
          onError: (value) => 0);

      if (enteredName.isEmpty) {
        return;
      }
      Tasbih tasbih = Tasbih(
        id: widget.tasbih.id,
        name: enteredName,
        numberOfDailyGroups: enteredNumberOfDailyGroups,
        numberOfTasbihPerGroup: enteredNumberOfTasbihPerGroup,
      );
      if (widget.addOrUpdateTasbih(tasbih)) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: CustomTheme.bgColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),

        //BorderRadius.circular(40),
      ),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Center(
              child: Text(
                (widget.tasbih.id == null || widget.tasbih.id == 0)
                    ? 'Add New Tasbih'
                    : 'Update Tasbih',
                style: CustomTheme.modalTitleTxtStyle,
              ),
            ),
            TextFormField(
              controller: tasbihNameController,
              decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: CustomTheme.infoTxtStyle,
                  counterStyle: CustomTheme.infoTxtStyle,
                  counterText: ""),
              maxLength: 50,
              maxLengthEnforced: true,
              inputFormatters: [LengthLimitingTextInputFormatter(50)],
              style: CustomTheme.modalInputTextStyle,
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Tasbih Name can\'t be empty';
                } else if (text.length > 50) {
                  return 'Tasbih Name is too long';
                }
                return null;
              },
            ),
            TextFormField(
              controller: numberOfTasbihPerGroupController,
              decoration: InputDecoration(
                labelText: 'Number of Tasbih Per Group',
                labelStyle: CustomTheme.infoTxtStyle,
              ),
              keyboardType: TextInputType.numberWithOptions(
                  decimal: false, signed: false),

              //onSubmitted: (_) => submitData(),
              style: CustomTheme.modalInputTextStyle,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Number of tasbih can\'t be empty';
                } else if (value.length > 3) {
                  return 'Tasbih Number is too long';
                }
                return null;
              },
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3),
              ],
            ),
            TextFormField(
              controller: numberOfDailyGroupsController,
              decoration: InputDecoration(
                labelText: 'Number of Daily Groups',
                labelStyle: CustomTheme.infoTxtStyle,
              ),
              keyboardType: TextInputType.numberWithOptions(
                  decimal: false, signed: false),
              //onSubmitted: (_) => submitData(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Number of tasbih can\'t be empty';
                } else if (value.length > 3) {
                  return 'Tasbih Number is too long';
                }
                return null;
              },
              style: CustomTheme.modalInputTextStyle,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              color: CustomTheme.color3,
              textColor: CustomTheme.color1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),

                // side: BorderSide(color: Colors.red),
              ),
              onPressed: () {
                submitData();
              },
              child: Text(
                widget.tasbih.id == 0 || widget.tasbih.id == null
                    ? 'Create'
                    : 'Update',
                //style: CustomTheme.,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
