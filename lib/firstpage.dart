import 'package:flutter/material.dart';
import 'package:test_jumana/secondpage.dart';
class firstpage extends StatefulWidget {
  const firstpage({Key? key}) : super(key: key);

  @override
  State<firstpage> createState() => _firstpageState();
}

class _firstpageState extends State<firstpage> {
  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("Select Data type"),value: "Select Data type"),
      const DropdownMenuItem(child: Text("Text"),value: "Text"),
      DropdownMenuItem(child: const Text("Numbers"),value: "Numbers"),
      DropdownMenuItem(child: const Text("Date"),value: "Date"),

    ];
    return menuItems;
  }
var num=TextEditingController();
  String selectedValue = "Select Data type";
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar:AppBar(title:  const Text("First Page"),),
      body: Form(
        child: Container(padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(width: MediaQuery.of(context).size.width*0.7,
                child: TextFormField(controller: num,keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Enter the Number of Fields", ),),
              ),
              const SizedBox(height: 10),
          Container(width: MediaQuery.of(context).size.width*0.7,child: DropdownButton(  hint: Text(selectedValue),value: selectedValue,items: dropdownItems, onChanged: ( String? newValue){
            setState(() {

              selectedValue=newValue!;
            });

          })),
              ElevatedButton(onPressed: (){
Navigator.of(context).pushNamed(secondpage.routename,arguments:[int.parse(num.text),selectedValue] );
              }, child: const Text("Next"))
            ],
          ),
        ),
      ),
    );
  }
}
