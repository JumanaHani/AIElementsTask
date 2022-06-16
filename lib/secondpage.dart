import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';

class secondpage extends StatefulWidget {
  static const routename = 'secondpage';
  const secondpage({Key? key}) : super(key: key);

  @override
  _secondpageState createState() => _secondpageState();
}

class _secondpageState extends State<secondpage> {
  List<String> _controllers = [];
  List<dynamic> _fields = [];
 // String DateValue="";
  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

var arg=ModalRoute.of(context)?.settings.arguments as List;
int FieldNum=arg[0];

String type=arg[1];

    for(int i=0;i<=FieldNum;i++){
      final field;
  final controller = TextEditingController();
      String DateValue="";
  if(type=="Date"){
    field =  DateTimeFormField(

      decoration: const InputDecoration(
        contentPadding: EdgeInsets.all(0),

      ),
      mode: DateTimeFieldPickerMode.date,
      autovalidateMode: AutovalidateMode.always,

      onDateSelected: (DateTime value) {
       // setState(() {
          DateValue=value.toString();
      //  });

      },
    );
  }
  else{  field = TextField(keyboardType:type=="Text"?TextInputType.text:TextInputType.number ,
    controller: controller,
    decoration: InputDecoration(
      border: const OutlineInputBorder(),
      labelText: "Input ${_controllers.length + 1}",
    ),
  );}


  setState(() {
    _controllers.add(controller.text!=""?controller.text:DateValue);
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
              Expanded(child: _listView()),
              _okButton(),
            ],
          ),
        ),
      ),
    );
  }
}
