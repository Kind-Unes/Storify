import 'package:flutter/material.dart';


//FIX: click on text doesnt set the option only clicking on the radio!!

class OptionList extends StatefulWidget {
  final List<String> options;
  Function? callback = ()  {};
  
  OptionList({super.key, required this.options,this.callback});

  @override
  State<OptionList> createState() => _OptionListState();
}

class _OptionListState extends State<OptionList> {
  int selected  = 1;

  void on_select(int? i) {
      setState(() {
        selected = i!;
      });
      widget.callback!(i);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, 
      children: [
      Text(
        widget.options[0],
        style: TextStyle(
          fontSize: 22,
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Column(
        crossAxisAlignment:  CrossAxisAlignment.start,
        children: [
          for (int i = 1; i < this.widget.options.length; i++)
            Column(
              children: [
                Container(
                  child: ListTile(
                    leading: Radio(value: i, groupValue: selected, onChanged:  (i) { on_select(i); }),
                    title: GestureDetector(
                      onTap: () =>  (i) { on_select(i); },
                      child: Text(
                        this.widget.options[i],
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                )
              ],
            )
        ],
      ),
      SizedBox(
        height: 20,
      ),
    ]);
  }
}