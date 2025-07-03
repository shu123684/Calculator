import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';

import 'package:calculator/button.dart';
import 'package:calculator/btn.dart';

class calculatorScreen extends StatefulWidget {
  const calculatorScreen({super.key});

  @override
  State<calculatorScreen> createState() => _calculatorScreenState();
}

class _calculatorScreenState extends State<calculatorScreen> {



  // ignore: prefer_final_fields
  TextEditingController _displayController = TextEditingController();
  TextEditingController _resultController = TextEditingController();

  // Auto Scroll
  final ScrollController _mainDisplayScrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  void _scrollToEndHorizontal() {
    if (_mainDisplayScrollController.hasClients) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _mainDisplayScrollController.animateTo(
          _mainDisplayScrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 80), // Adjust duration
          curve: Curves.easeOut, // Adjust animation curve
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _displayController.addListener(_scrollToEndHorizontal); // Add listener
    _focusNode
        .requestFocus(); // Ensure TextField has focus if needed for cursor
  }

  @override
  void dispose() {
    _displayController.removeListener(
      _scrollToEndHorizontal,
    ); // Remove listener
    _displayController.dispose();
    _resultController.dispose();
    _mainDisplayScrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final btnSpace = MediaQuery.of(context).size.height*.54;
    final btnHeight = (btnSpace-45)/5;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings, color: Theme.of(context).primaryColor),
            onPressed: () {
              Navigator.pushNamed(context, '/settingsScreen');
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
                scrollController: _mainDisplayScrollController,
                style: TextStyle(color: Colors.white, fontSize: 50),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: Btn.n0,
                  hintStyle: TextStyle(
                    color: Colors.white38,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                maxLines: 1,
                minLines: 1,
              ),
            ),
          ),

          SingleChildScrollView(
            reverse: true,
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 9),
              child: TextField(
                keyboardType: TextInputType.none,
                autofocus: false,
                enabled: true,
                showCursor: false,
                readOnly: true,
                enableInteractiveSelection: false,
                textAlign: TextAlign.end,
                controller: _resultController,
                style: TextStyle(
                  color: Colors.white38,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 1),
            child: Divider(),
          ),
          SizedBox(
            height: btnSpace,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // 1st Container
                  children: [
                    CustomCircleButton(
                      title: Btn.clr,
                      font_size: 24.5,
                      color: Colors.grey,
                      height: btnHeight,
                      onClick: () {
                        buttonTap(Btn.clr);
                      },
                    ),
                    CustomCircleButton(
                      icon_size: 29,
                      color: Colors.grey,
                      height: btnHeight,
                      icondata: Icons.backspace_outlined,
                      onClick: () {
                        buttonTap(Btn.del);
                      },
                    ),
                    CustomCircleButton(
                      title: Btn.negpos,
                      font_size: 28,
                      color: Colors.grey,
                      height: btnHeight,
                      onClick: () {
                        buttonTap(Btn.negpos);
                      },
                    ),
                    CustomCircleButton(
                      title: "÷",
                      font_size: 30,
                      color: Colors.amber,
                      height: btnHeight,
                      splashColor: Colors.amberAccent,
                      onClick: () {
                        buttonTap(Btn.divide);
                      },
                    ),
                  ], // children
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // 2nd Container
                  children: [
                    CustomCircleButton(
                      title: Btn.n7,
                      font_size: 28,
                      color: Colors.white38,
                      height: btnHeight,
                      onClick: () {
                        buttonTap(Btn.n7);
                      },
                    ),
                    CustomCircleButton(
                      title: Btn.n8,
                      font_size: 28,
                      color: Colors.white38,
                      height: btnHeight,
                      onClick: () {
                        buttonTap(Btn.n8);
                      },
                    ),
                    CustomCircleButton(
                      title: Btn.n9,
                      font_size: 28,
                      color: Colors.white38,
                      height: btnHeight,
                      onClick: () {
                        buttonTap(Btn.n9);
                      },
                    ),
                    CustomCircleButton(
                      title: "×",
                      font_size: 28,
                      color: Colors.amber,
                      height: btnHeight,
                      splashColor: Colors.amberAccent,
                      onClick: () {
                        buttonTap(Btn.multiply);
                      },
                    ),
                  ], // children
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // !st Container
                  children: [
                    CustomCircleButton(
                      title: Btn.n4,
                      font_size: 28,
                      color: Colors.white38,
                      height: btnHeight,
                      onClick: () {
                        buttonTap(Btn.n4);
                      },
                    ),
                    CustomCircleButton(
                      title: Btn.n5,
                      font_size: 28,
                      color: Colors.white38,
                      height: btnHeight,
                      onClick: () {
                        buttonTap(Btn.n5);
                      },
                    ),
                    CustomCircleButton(
                      title: Btn.n6,
                      font_size: 28,
                      color: Colors.white38,
                      height: btnHeight,
                      onClick: () {
                        buttonTap(Btn.n6);
                      },
                    ),
                    CustomCircleButton(
                      title: Btn.subtract,
                      font_size: 28,
                      color: Colors.amber,
                      height: btnHeight,
                      splashColor: Colors.amberAccent,
                      onClick: () {
                        buttonTap(Btn.subtract);
                      },
                    ),
                  ], // children
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // !st Container
                  children: [
                    CustomCircleButton(
                      title: Btn.n1,
                      font_size: 28,
                      color: Colors.white38,
                      height: btnHeight,
                      onClick: () {
                        buttonTap(Btn.n1);
                      },
                    ),
                    CustomCircleButton(
                      title: Btn.n2,
                      font_size: 28,
                      color: Colors.white38,
                      height: btnHeight,
                      onClick: () {
                        buttonTap(Btn.n2);
                      },
                    ),
                    CustomCircleButton(
                      title: Btn.n3,
                      font_size: 28,
                      color: Colors.white38,
                      height: btnHeight,
                      onClick: () {
                        buttonTap(Btn.n3);
                      },
                    ),
                    CustomCircleButton(
                      title: Btn.add,
                      font_size: 28,
                      color: Colors.amber,
                      height: btnHeight,
                      splashColor: Colors.amberAccent,
                      onClick: () {
                        buttonTap(Btn.add);
                      },
                    ),
                  ], // children
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // !st Container
                  children: [
                    CustomCircleButton(
                      title: Btn.per,
                      font_size: 28,
                      color: Colors.white38,
                      height: btnHeight,
                      onClick: () {
                        buttonTap(Btn.per);
                      },
                    ),
                    CustomCircleButton(
                      title: Btn.n0,
                      font_size: 28,
                      color: Colors.white38,
                      height: btnHeight,
                      onClick: () {
                        buttonTap(Btn.n0);
                      },
                    ),
                    CustomCircleButton(
                      title: Btn.dot,
                      font_size: 28,
                      color: Colors.white38,
                      height: btnHeight,

                      onClick: () {
                        buttonTap(Btn.dot);
                      },
                    ),
                    CustomCircleButton(
                      title: Btn.calculate,
                      font_size: 28,
                      color: Colors.amber,
                      height: btnHeight,
                      splashColor: Colors.amberAccent,
                      onClick: () {
                        buttonTap(Btn.calculate);
                      },
                    ),
                  ], // children
                ),
              ],
            ),
          ),
        ], //children
      ),
    );
  }

  void buttonTap(String value) {
    if (value == Btn.clr) {
      allclr();
      return;
    } else if (value == Btn.del) {
      delete();
      return;
    } else if (value == Btn.negpos) {
      negpos();
      return;
    } else if (value == Btn.per) {
      percentage();
      return;
    } else if (value == Btn.calculate) {
      calculate();
      return;
    }
    setValue(value);
    update_resultController();
  }

  void calculate() {
    _displayController.text = _resultController.text;
    _resultController.text = "";
    setState(() {});
  }

  void setValue(String value) {
    // Experiment
    var cursorPos = _displayController.selection.baseOffset;
    String prefixText = _displayController.text.substring(0, cursorPos);
    String suffixText = _displayController.text.substring(cursorPos);

    // Option 2 (using RegExp)
    if (RegExp(r"[-+*/.]").hasMatch(_displayController.text)) {
      if (((cursorPos == _displayController.text.indexOf(Btn.subtract) ||
                  cursorPos == _displayController.text.indexOf(Btn.add) ||
                  cursorPos == _displayController.text.indexOf(Btn.divide) ||
                  cursorPos == _displayController.text.indexOf(Btn.multiply) ||
                  cursorPos == _displayController.text.indexOf(Btn.dot)) ||
              ((cursorPos ==
                      _displayController.text.indexOf(Btn.subtract) + 1 ||
                  cursorPos == _displayController.text.indexOf(Btn.add) + 1 ||
                  cursorPos ==
                      _displayController.text.indexOf(Btn.divide) + 1 ||
                  cursorPos ==
                      _displayController.text.indexOf(Btn.multiply) + 1 ||
                  cursorPos ==
                      _displayController.text.indexOf(Btn.dot) + 1))) &&
          (value == Btn.subtract ||
              value == Btn.add ||
              value == Btn.divide ||
              value == Btn.multiply ||
              value == Btn.dot)) {
        value = "";
      }
    }

    if (value == Btn.dot) {
      if (dotCheck()) {
        value = "";
      } else if (_displayController.text.isEmpty) {
        value = "0.";
      }
    }

    if (_displayController.text.contains("(") ||
        _displayController.text.contains(")")) {
      if (((cursorPos == _displayController.text.indexOf("(") ||
              (cursorPos == _displayController.text.indexOf(")") + 1)) &&
          (value == Btn.n0 ||
              value == Btn.n1 ||
              value == Btn.n2 ||
              value == Btn.n3 ||
              value == Btn.n4 ||
              value == Btn.n5 ||
              value == Btn.n6 ||
              value == Btn.n7 ||
              value == Btn.n8 ||
              value == Btn.n9 ||
              value == Btn.dot))) {
        value = "";
      }
    }

    if (value != "") {
      _displayController.text = prefixText + value + suffixText;
      _displayController.selection = TextSelection.fromPosition(
        TextPosition(offset: cursorPos + value.length),
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

    if (_displayController.text.startsWith("(-") &&
        _displayController.text.endsWith(")")) {
      _displayController.text = _displayController.text.substring(
        2,
        _displayController.text.length - 1,
      );
    }
    if (RegExp(r"[-+*/]").hasMatch(_displayController.text)) {
      _displayController.text = "-(${_displayController.text})";
    } else {
      if (_displayController.text.startsWith(Btn.subtract)) {
        _displayController.text = _displayController.text.substring(1);
      } else {
        _displayController.text = Btn.subtract + _displayController.text;
      }
    }
    setState(() {
      update_resultController();
    });
  }

  void percentage() {
    if (_displayController.text == "") return;
    _displayController.text = "(${_displayController.text})%";

    double num = _displayController.text.interpret().toDouble() / 100;
    _resultController.text = num.toString();

    setState(() {
      update_resultController();
    });
  }

  bool dotCheck() {
    if (!_displayController.text.contains(Btn.dot)) return false;
    int i = _displayController.selection.baseOffset - 1;
    int j = _displayController.selection.baseOffset - 1;

    // right check
    bool rightcheck = false;
    for (
      i;
      i < _displayController.text.length &&
          (_displayController.text[i] != Btn.add &&
              _displayController.text[i] != Btn.subtract &&
              _displayController.text[i] != Btn.multiply &&
              _displayController.text[i] != Btn.divide);
      i++
    ) {
      if (_displayController.text[i] == Btn.dot) {
        rightcheck = true;
        break;
      }
    }

    //Left check
    bool leftcheck = false;
    for (
      j;
      j >= 0 &&
          (_displayController.text[j] != Btn.add &&
              _displayController.text[j] != Btn.subtract &&
              _displayController.text[j] != Btn.multiply &&
              _displayController.text[j] != Btn.divide);
      j--
    ) {
      if (_displayController.text[j] == Btn.dot) {
        leftcheck = true;
        break;
      }
    }
    if (leftcheck || rightcheck) {
      return true;
    } else {
      return false;
    }
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
      _resultController.text = removeTrailingZeros(
        _displayController.text.interpret().toDouble(),
      );
      if (_resultController.text.endsWith(".0")) {
        _resultController.text = _resultController.text.substring(
          0,
          _resultController.text.indexOf(Btn.dot),
        );
      }
      if ((_resultController.text.length -
              _resultController.text.indexOf(Btn.dot)) >
          7) {
        _resultController.text = _resultController.text.substring(
          0,
          _resultController.text.indexOf(Btn.dot) + 7,
        );
      }
    } else {
      _resultController.text = "";
    }
  }
}
