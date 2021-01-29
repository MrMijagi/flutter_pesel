import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'PESEL Validation';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: PESELValidator(),
      ),
    );
  }
}

class PESELValidator extends StatefulWidget {
  @override
  PESELValidatorState createState() {
    return PESELValidatorState();
  }
}

class PESELValidatorState extends State<PESELValidator> {
  final _formKey = GlobalKey<FormState>();
  String birthday = "";
  String gender = "";
  String checkSum = "";
  bool visible = false;
  final myController = TextEditingController();

  void _validatePESEL() {
    setState(() {
      int month = int.parse(myController.text.substring(2, 4));
      String day = myController.text.substring(4, 6);
      String year;
      String monthS;
      if (month < 20) {
        year = "19" + myController.text.substring(0, 2);
        monthS = myController.text.substring(2, 4);
      } else if (month < 40) {
        year = "20" + myController.text.substring(0, 2);
        monthS = (month - 20).toString().padLeft(2, '0');
      } else if (month < 60) {
        year = "21" + myController.text.substring(0, 2);
        monthS = (month - 40).toString().padLeft(2, '0');
      } else if (month < 80) {
        year = "22" + myController.text.substring(0, 2);
        monthS = (month - 60).toString().padLeft(2, '0');
      } else {
        year = "18" + myController.text.substring(0, 2);
        monthS = (month - 80).toString().padLeft(2, '0');
      }
      birthday = day + "." + monthS + "." + year;

      if (int.parse(myController.text.substring(9, 10)) % 2 == 0) {
        gender = "She";
      } else {
        gender = "He";
      }

      var wages = [1, 3, 7, 9, 1, 3, 7, 9, 1, 3];
      var sum = 0;
      for (int i = 0; i < wages.length; i++) {
        sum += int.parse(myController.text[i]) * wages[i];
      }

      if (10 - (sum % 10) == int.parse(myController.text[10])) {
        checkSum = "correct";
      } else {
        checkSum = "incorrect";
      }

      visible = true;
    });
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
          TextFormField(
              validator: (value) {
                if (value.length != 11) {
                  return 'The text must be 11 characters long';
                }
                return null;
              },
              controller: myController),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _validatePESEL();
              }
            },
            child: Text('Submit'),
          ),
          Visibility(
            visible: visible,
            child: Column(
              children: [
                Padding(
                  padding: new EdgeInsets.all(10),
                  child: Text('Birthday: ' + birthday,
                      style: TextStyle(color: Colors.cyan[800], fontSize: 30)),
                ),
                Padding(
                  padding: new EdgeInsets.all(10),
                  child: Text('Gender: ' + gender,
                      style: TextStyle(color: Colors.blue[800], fontSize: 30)),
                ),
                Padding(
                  padding: new EdgeInsets.all(10),
                  child: Text('Checksum: ' + checkSum,
                      style:
                          TextStyle(color: Colors.purple[800], fontSize: 30)),
                ),
              ],
            ),
          ),
        ]));
  }
}
