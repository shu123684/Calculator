import 'package:flutter/material.dart';
import 'package:calculator/button.dart';
import 'package:function_tree/function_tree.dart';

import 'button.dart' show CustomCircleButton;

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   // + - * /

  // ignore: prefer_final_fields
  TextEditingController _displayController = TextEditingController();
  TextEditingController _resultController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              print("Settings");
            },
          ),
        ],
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SingleChildScrollView(
            reverse: true,

            // Display Controller Update
            child: Container(
              color: Colors.blue,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextField(
                keyboardType: TextInputType.none,
                autofocus: true,
                enabled: true,
                showCursor: true, // <--- SET THIS TO TRUE TO SHOW THE CURSOR
                cursorColor: Colors.white, // <--- Optional: Set cursor color
                cursorWidth: 2.0,
                cursorHeight: 60, // <--- Optional: Set cursor width
                cursorRadius: Radius.circular(1),
                textAlign: TextAlign.end,
                controller: _displayController,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "0",
                  hintStyle: TextStyle(
                    color: Colors.white38,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          SingleChildScrollView(
            reverse: true,
            child: Container(
              color: Colors.red,
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextField(
                keyboardType: TextInputType.none,
                autofocus: false,
                enabled: false,
                showCursor: false,
                readOnly: true,
                enableInteractiveSelection: false,
                textAlign: TextAlign.end,
                controller : _resultController,
                style: TextStyle(
                  color: Colors.white38,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // !st COntainer
            children: [
              CustomCircleButton(
                title: "AC",
                font_size: 24.5,
                color: Colors.grey,
                onClick: () {
                  buttonTap("AC");
                },
              ),
              CustomCircleButton(
                icon_size: 29,
                color: Colors.grey,
                icondata: Icons.backspace_outlined,
                onClick: () {
                  buttonTap("del");
                },
              ),
              CustomCircleButton(
                title: "-/+",
                font_size: 28,
                color: Colors.grey,
                onClick: () {
                  buttonTap("-/+");
                },
              ),
              CustomCircleButton(
                title: "÷",
                font_size: 30,
                color: Colors.amber,
                splashColor: Colors.amberAccent,
                onClick: () {
                  buttonTap("/");
                },
              ),
            ], // children
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // !st COntainer
            children: [
              CustomCircleButton(
                title: "7",
                font_size: 28,
                color: Colors.white38,
                onClick: () {
                  buttonTap("7");
                },
              ),
              CustomCircleButton(
                title: "8",
                font_size: 28,
                color: Colors.white38,
                onClick: () {
                  buttonTap("8");
                },
              ),
              CustomCircleButton(
                title: "9",
                font_size: 28,
                color: Colors.white38,
                onClick: () {
                  buttonTap("9");
                },
              ),
              CustomCircleButton(
                title: "*",
                font_size: 28,
                color: Colors.amber,
                splashColor: Colors.amberAccent,
                onClick: () {
                  buttonTap("*");
                },
              ),
            ], // children
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // !st COntainer
            children: [
              CustomCircleButton(
                title: "4",
                font_size: 28,
                color: Colors.white38,
                onClick: () {
                  buttonTap("4");
                },
              ),
              CustomCircleButton(
                title: "5",
                font_size: 28,
                color: Colors.white38,
                onClick: () {
                  buttonTap("5");
                },
              ),
              CustomCircleButton(
                title: "6",
                font_size: 28,
                color: Colors.white38,
                onClick: () {
                  buttonTap("6");
                },
              ),
              CustomCircleButton(
                title: "-",
                font_size: 28,
                color: Colors.amber,
                splashColor: Colors.amberAccent,
                onClick: () {
                  buttonTap("-");
                },
              ),
            ], // children
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // !st COntainer
            children: [
              CustomCircleButton(
                title: "1",
                font_size: 28,
                color: Colors.white38,
                onClick: () {
                  buttonTap("1");
                },
              ),
              CustomCircleButton(
                title: "2",
                font_size: 28,
                color: Colors.white38,
                onClick: () {
                  buttonTap("2");
                },
              ),
              CustomCircleButton(
                title: "3",
                font_size: 28,
                color: Colors.white38,
                onClick: () {
                  buttonTap("3");
                },
              ),
              CustomCircleButton(
                title: "+",
                font_size: 28,
                color: Colors.amber,
                splashColor: Colors.amberAccent,
                onClick: () {
                  buttonTap("+");
                },
              ),
            ], // children
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // !st COntainer
            children: [
              // CustomCircleButton(title: "%", font_size: 28, color: Colors.white38,),
              CustomCircleButton(
                title: "0",
                font_size: 28,
                color: Colors.white38,
                flex: 2,
                shape: 60,
                onClick: () {
                  buttonTap("0");
                },
              ),
              CustomCircleButton(
                title: ".",
                font_size: 28,
                color: Colors.white38,

                onClick: () {
                  buttonTap(".");
                },
              ),
              CustomCircleButton(
                title: "=",
                font_size: 28,
                color: Colors.amber,
                splashColor: Colors.amberAccent,
                onClick: () {
                  buttonTap("=");
                },
              ),
            ], // children
          ),
        ], //children
      ),
    );
  }

  void buttonTap(String value) {
    if (value == "AC") {
      allclr();
      return;
    } else if (value == "del") {
      delete();
      return;
    } else if (value == "-/+") {
      negpos();
      return;
    } else if (value == "=") {
      calculate();
      return;
    }
    setValue(value);
    update_resultController();
  }

  void calculate() {
    _displayController.text = removeTrailingZeros(
      _displayController.text.interpret().toDouble(),
    );
    if (_displayController.text.endsWith(".0")) {
      _displayController.text = _displayController.text.substring(
        0,
        _displayController.text.indexOf("."),
      );
    }
    _resultController.text = "";
    setState(() {});
  }

  void setValue(String value) {
    // Experiment
    var cursorPos = _displayController.selection.baseOffset;
    String prefixText = _displayController.text.substring(0, cursorPos);
    String suffixText = _displayController.text.substring(cursorPos);

    if (((cursorPos == _displayController.text.indexOf("-") ||
                cursorPos == _displayController.text.indexOf("+") ||
                cursorPos == _displayController.text.indexOf("/") ||
                cursorPos == _displayController.text.indexOf("*")) ||
            ((cursorPos == _displayController.text.indexOf("-") + 1 ||
                cursorPos == _displayController.text.indexOf("+") + 1 ||
                cursorPos == _displayController.text.indexOf("/") + 1 ||
                cursorPos == _displayController.text.indexOf("*") + 1))) &&
        (value == "-" || value == "+" || value == "/" || value == "*")) {
      value = "";
    }

    if (value == "." && _displayController.text.contains(".")) {
      value = "";
    } else if (value == "." && _displayController.text.isEmpty) {
      value = "0.";
    }

    if (_displayController.text.contains("(") ||
        _displayController.text.contains(")")) {
      if (((cursorPos == _displayController.text.indexOf("(") ||
              (cursorPos == _displayController.text.indexOf(")") + 1)) &&
          (value == "0" ||
              value == "1" ||
              value == "2" ||
              value == "3" ||
              value == "4" ||
              value == "5" ||
              value == "6" ||
              value == "7" ||
              value == "8" ||
              value == "9" ||
              value == "."))) {
        value = "";
      }
    }

    if ((_displayController.text + value).length !=
        _displayController.text.length) {
      _displayController.text = prefixText + value + suffixText;
      _displayController.selection = TextSelection.fromPosition(
        TextPosition(offset: cursorPos + 1),
      );
    }

    setState(() {});
  }

  void delete() {
    var cursorPos = _displayController.selection.baseOffset;
    String prefixText = _displayController.text.substring(0, cursorPos);
    String suffixText = _displayController.text.substring(cursorPos);

    _displayController.text =
        prefixText.substring(0, cursorPos - 1) + suffixText;

    _displayController.selection = TextSelection.fromPosition(
      TextPosition(offset: cursorPos - 1),
    );

    update_resultController();
    setState(() {});
  }

  void allclr() {
    setState(() {
      _displayController.text = "";
      _resultController.text = "";
    });
  }

  void negpos() {
    if (_displayController.text == "") return;
    String neg = "-";

    if(!(_displayController.text.startsWith("-"))){
      _displayController.text = "($neg" + _displayController.text + ")";
    }else _displayController.text = _displayController.text.substring(1);
    setState(() {
      update_resultController();
    });
  }

  String removeTrailingZeros(double n) {
    return double.parse(
      n.toStringAsFixed(
        n.truncateToDouble() == n ? 0 : n.toString().split('.')[1].length,
      ),
    ).toString();
  }

  void update_resultController() {
    if (_displayController.text.isNotEmpty) {
      _resultController.text = removeTrailingZeros(_displayController.text.interpret().toDouble());

      if (_resultController.text.endsWith(".0")) {
        _resultController.text = _resultController.text.substring(0, _resultController.text.indexOf("."));
      }
    }else {
      _resultController.text = "";
    }
    print(_resultController);
  }
}
