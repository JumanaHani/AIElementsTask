import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:test_jumana/firstpage.dart';

class secondpage extends StatefulWidget {
  static const routename = 'secondpage';
  const secondpage({Key? key}) : super(key: key);

  @override
  _secondpageState createState() => _secondpageState();
}

class _secondpageState extends State<secondpage> {
  final focus = FocusNode();
var _key=GlobalKey<FormState>();
  List<dynamic> _fields = [];
  List<String> _controllers = [];
  String DateValue="";
  @override
  Widget build(BuildContext context) {

    var controller = TextEditingController();


var arg=ModalRoute.of(context)?.settings.arguments as List;
int FieldNum=arg[0];

String type=arg[1];

    for(int i=0;i<=FieldNum;i++){
      final field;
  var controller = TextEditingController();

  if(type=="Date"){

    field =  DateTimeFormField(

      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: "Input ${i + 1}",
      ),
      mode: DateTimeFieldPickerMode.date,
      autovalidateMode: AutovalidateMode.always,

      onDateSelected: (DateTime value) {
        _controllers.add(value.toString());
      //  setState(() {
          DateValue=value.toString();
      // });

      },
    );
  }
  else{  field = FocusScope(
    onFocusChange: (value) {
      if (!value) {
        _controllers.add(controller.value.text);
        //here checkAndUpdate();
      }
    },
    child: TextField(keyboardType:type=="Text"?TextInputType.text:TextInputType.number ,
      textInputAction: TextInputAction.next,
      controller: controller,
      onEditingComplete: (){
        FocusScope.of(context).requestFocus(focus);
      },
      onChanged: (val){




      },

      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: "Input ${i + 1}",
      ),
    ),
  );

  }


 setState(() {

    _fields.add(field);
  });

}
    Widget _listView() {
      return ListView.builder(
        itemCount: FieldNum,

        itemBuilder: (context, index) {

          return Container(
            margin: const EdgeInsets.all(5),
            child:  _fields[index]);
        });

    }
    Widget _okButton() {
      return ElevatedButton(
        onPressed: () async {
          _key.currentState?.save();
          String text = _controllers
              .where((element) => element != "")
              .fold("", (acc, element) => acc += "${element}\n");
          final alert = AlertDialog(
            title: const Text("The Response"),
            content: Text(text.trim()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
          await showDialog(
            context: context,
            builder: (BuildContext context) => alert,
          );
          setState(() {});
        },
        child: const Text("OK"),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Second page"),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width*0.7,
          height:  MediaQuery.of(context).size.height*0.8,
          child: Column(
            children: [
              Align(child: TextButton(onPressed: (){
                Navigator.of(context).pushReplacementNamed(firstpage.routename);
              }
              ,child: const Text("Create new form"),),),
              Expanded(child: _listView()),
              _okButton(),
            ],
          ),
        ),
      ),
    );
  }
}
