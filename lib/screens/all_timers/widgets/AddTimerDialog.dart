import 'package:flutter/material.dart';
import 'package:dmb_timer_3/screens/all_timers/utilities/Timer.dart';
import 'package:dmb_timer_3/screens/all_timers/utilities/DbHelper.dart';

class AddTimerDialog extends StatefulWidget {
  @override
  _AddTimerDialogState createState() => _AddTimerDialogState();
}

class _AddTimerDialogState extends State<AddTimerDialog> {
  TextEditingController controller = TextEditingController();
  Color formColor, buttonStartColor, buttonEndCollor;
  String name;
  DateTime dateStart, dateEnd;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    name = '';
    formColor = Colors.green;
    buttonStartColor = buttonEndCollor = Colors.green[400];
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Заповніть Форму'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text('Ім\'я:'),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              height: 55,
              width: 240,
              child: TextField(
                maxLength: 20,
                controller: controller,
                onChanged: (value) => name = value,
                decoration: InputDecoration(
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: formColor, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: formColor, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: formColor, width: 1.0),
                  ),
                  labelText: 'Введіть ім\'я',
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text('Дата початку:'),
            MaterialButton(
              onPressed: () async {
                DateTime date = await pickDate(context);
                setState(() {
                  date != null ? buttonStartColor = Colors.green[400] : null;
                  dateStart = date;
                });
              },
              child: Text(
                "${dateStart != null ? dateStart.toString().substring(0, 10) : 'Виберіть дату'}",
                style: TextStyle(color: Colors.white),
              ),
              color: buttonStartColor,
            ),
            SizedBox(
              height: 30,
            ),
            Text('Дата завершення:'),
            MaterialButton(
              onPressed: () async {
                DateTime date = await pickDate(context);
                setState(() {
                  date != null ? buttonEndCollor = Colors.green[400] : null;
                  dateEnd = date;
                });
              },
              child: Text(
                "${dateEnd != null ? dateEnd.toString().substring(0, 10) : 'Виберіть дату'}",
                style: TextStyle(color: Colors.white),
              ),
              color: buttonEndCollor,
            )
          ],
        ),
      ),
      actions: [
        MaterialButton(
          elevation: 3.0,
          child: Text('Скасувати'),
          onPressed: () {
            // clearName();
            Navigator.of(context).pop();
          },
        ),
        MaterialButton(
          elevation: 3.0,
          child: Text('Зберегти'),
          onPressed: () async {
            bool error = false;
            Color color1 = Colors.green[400];
            Color color2 = Colors.green[400];
            Color color3 = Colors.green[400];
            if (name.length < 1) {
              color1 = Colors.red;
              error = true;
            }
            if (dateStart == null) {
              color2 = Colors.red;
              error = true;
            }
            if (null == dateEnd) {
              color3 = Colors.red;
              error = true;
            }
            if (error) {
              setState(() {
                formColor = color1;
                buttonStartColor = color2;
                buttonEndCollor = color3;
              });
              return;
            }
            await save();
          },
        )
      ],
    );
  }

  Future<DateTime> pickDate(BuildContext context) async {
    DateTime dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 365 * 6)),
      lastDate: DateTime.now().add(Duration(days: 365 * 5)),
      locale: Locale('uk'),
    );

    return dateTime;
  }

  save() async {
    Timer e = Timer(null, name, dateStart.millisecondsSinceEpoch,
        dateEnd.millisecondsSinceEpoch);
    await dbHelper
        .save(e)
        .then((value) => globalTimers.add(e))
        .then((value) => globalTimersLength.value++);
    Navigator.of(context).pop();
  }
}
