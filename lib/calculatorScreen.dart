import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:function_tree/function_tree.dart';

import 'package:calculator/button.dart';
import 'package:calculator/btn.dart';

class calculatorScreen extends StatefulWidget {
  const calculatorScreen({super.key});

  @override
  State<calculatorScreen> createState() => _calculatorScreenState();
}

class _calculatorScreenState extends State<calculatorScreen> {
  // Error text
  String errorText = "";
  bool _showStaticError = false;
  CancelableOperation<void>? _errorDisplayOperation;

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
    _errorDisplayOperation?.cancel();
    _displayController.dispose();
    _displayController.dispose();
    _resultController.dispose();
    _mainDisplayScrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final btnSpace = MediaQuery.of(context).size.height * .59; // 0.59
    final btnHeight = (btnSpace - 45) / 6;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AnimatedOpacity(
            opacity: _showStaticError ? 1.0 : 0.0,
            duration: Duration(milliseconds: 600),
            child: Text(
              errorText,
              style: TextStyle(color: Colors.orange[400], fontSize: 12),
            ),
          ),
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
              padding: EdgeInsets.fromLTRB(20, 0, 20, 1),
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
                      title: Btn.rnd,
                      font_size: 25,
                      color: Colors.grey,
                      height: btnHeight,
                      onClick: () {
                        buttonTap(Btn.rnd);
                      },
                    ),
                    CustomCircleButton(
                      title: Btn.lbrack,
                      font_size: 28,
                      color: Colors.grey,
                      height: btnHeight,
                      onClick: () {
                        buttonTap(Btn.lbrack);
                      },
                    ),
                    CustomCircleButton(
                      title: Btn.rbrack,
                      font_size: 28,
                      color: Colors.grey,
                      height: btnHeight,
                      onClick: () {
                        buttonTap(Btn.rbrack);
                      },
                    ),
                    CustomCircleButton(
                      title: Btn.factorial,
                      font_size: 30,
                      color: Colors.amber,
                      height: btnHeight,
                      splashColor: Colors.amberAccent,
                      onClick: () {
                        buttonTap(Btn.factorial);
                      },
                    ),
                  ], // children
                ),
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
                      title: Btn.divide,
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
                      title: Btn.multiply,
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
    } else if (value == Btn.rnd) {
      round();
      return;
    } else if (value == Btn.per) {
      percent();
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
    if (((cursorPos == _displayController.text.indexOf(Btn.subtract) ||
                cursorPos == _displayController.text.indexOf(Btn.add) ||
                cursorPos == _displayController.text.indexOf(Btn.divide) ||
                cursorPos == _displayController.text.indexOf(Btn.multiply) ||
                cursorPos == _displayController.text.indexOf(Btn.dot)) ||
            ((cursorPos == _displayController.text.indexOf(Btn.subtract) + 1 ||
                cursorPos == _displayController.text.indexOf(Btn.add) + 1 ||
                cursorPos == _displayController.text.indexOf(Btn.divide) + 1 ||
                cursorPos ==
                    _displayController.text.indexOf(Btn.multiply) + 1 ||
                cursorPos == _displayController.text.indexOf(Btn.dot) + 1))) &&
        (RegExp(r"[-+×÷.]").hasMatch(value))) {
      value = "";
    }

    if (value == Btn.dot) {
      if (dotCheck()) {
        value = "";
      } else if (_displayController.text.isEmpty) {
        value = "0.";
      }
    }

    if (_displayController.text.contains("Rnd[")) {
      int offset = 0;
      if (cursorPos == _displayController.text.length) offset++;
      if (_displayController.text[cursorPos - 1] == "R" ||
          _displayController.text[cursorPos - 1] == "n" ||
          _displayController.text[cursorPos - 1] == "d" ||
          _displayController.text[cursorPos - offset] == "[") {
        value = "";
      }
    }
    if ((_displayController.text.contains(Btn.lbrack) ||
            _displayController.text.contains(Btn.rbrack)) &&
        RegExp(r"\d").hasMatch(value)) {
      if (cursorPos == _displayController.text.indexOf(Btn.lbrack)) {
        value = "$value${Btn.multiply}";
      }
      if ((cursorPos == _displayController.text.indexOf(Btn.rbrack) + 1) ||
          (cursorPos == _displayController.text.indexOf("]") + 1)) {
        value = "${Btn.multiply}$value";
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

    int offsetDel = 1; // Offset for delete operation
    int offset = 0; // offet for round operation "["
    if(cursorPos == _displayController.text.length) offset++;
    if (_displayController.text[cursorPos - 1] == "R" ||
        _displayController.text[cursorPos - 1] == "n" ||
        _displayController.text[cursorPos - 1] == "d" ||
        _displayController.text[cursorPos - offset] == "[" || // <--- Offset
        _displayController.text[cursorPos - 1] == "[" ||
        _displayController.text[cursorPos - 1] == "]") {
      _displayController.text = _displayController.text.replaceAll("Rnd[", "");
      _displayController.text = _displayController.text.replaceAll("]", "");
      return;
    }

    _displayController.text =
        prefixText.substring(0, cursorPos - offsetDel) + suffixText; // OffsetDel

    _displayController.selection = TextSelection.fromPosition(
      TextPosition(offset: cursorPos - offsetDel), // OffsetDel
    );

    update_resultController();
    setState(() {});
  }

  void allclr() {
    setState(() {
      _displayController.text = "";
      _resultController.text = "";
      displayError("All Cleared");
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

  void round() {
    if (_resultController.text.isEmpty) return;
    if (_displayController.text.contains("Rnd[")) return;

    // Experiment
    _displayController.text = "Rnd[${_displayController.text}]";

    _resultController.text = (double.parse(
      _resultController.text,
    ).round()).toString();

    setState(() {});
  }

  void percent() {
    if (_displayController.text.isEmpty) {
      displayError("Empty!");
      return;
    }
    _displayController.text = "(${_displayController.text})/100";
    setState(() {
      update_resultController();
    });
  }

  void displayError(String message) {
    // 1. Cancel any previous operation
    _errorDisplayOperation?.cancel(); // If there's an old one, cancel it

    // 2. Set the error message and make it visible immediately
    setState(() {
      errorText = message; // Set the dynamic error message
      _showStaticError = true; // Trigger fade-IN (or ensure it's visible)
    });

    // 3. Schedule the new cancellable operation to hide the error later
    _errorDisplayOperation = CancelableOperation.fromFuture(
      Future.delayed(Duration(seconds: 7)), // The actual delay
      onCancel: () {
        // Optional: Code to run if the operation is cancelled
        // This onCancel is for the CancelableOperation itself, not for the Future.
        // The Future inside won't complete if cancelled.
      },
    );

    _errorDisplayOperation?.value
        .then((_) {
          // This 'then' block executes only if the Future.delayed completes naturally (not cancelled)
          if (mounted && _showStaticError && errorText == message) {
            setState(() {
              _showStaticError = false; // Trigger fade-OUT
              errorText = ""; // Optionally clear the error text
            });
          }
        })
        .catchError((error) {
          if (error) {
            // Don't treat cancellation as an error to log
            print("Error in error display operation: $error");
          }
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
    try {
      if (_displayController.text.isNotEmpty) {
        String ctext = _displayController.text;
        if (ctext.contains("Rnd[") && ctext.contains("]")) {
          String num1 = ctext.substring(
            ctext.indexOf("Rnd[") + 4,
            ctext.indexOf("]"),
          ); // num1 is the number to be rounded inside Rnd[] with 'Btn.multiply' OR 'Btn.divide'
          String num = conversion(
            num1,
          ); // Num stores the proper num1 with '*' OR '/'
          int rnd = num.interpret().round(); // interpret and round num
          ctext = ctext.replaceAll(
            "Rnd[$num1",
            "$rnd",
          ); // Replaces the old num1 string with new rounded integer
          ctext = ctext.replaceAll("]", "");
        }
        ctext = conversion(ctext);

        // Interpret the value of the _displayController into _resultController
        _resultController.text = ctext.interpret().toString();

        if (_resultController.text.contains(Btn.dot)) {
          if ((_resultController.text.length -
                  _resultController.text.indexOf(Btn.dot)) >
              7) {
            _resultController.text = _resultController.text.substring(
              0,
              _resultController.text.indexOf(Btn.dot) + 7,
            );
          }
        }

        // Remove trailing zeros in _resultController
        _resultController.text = removeTrailingZeros(
          double.parse(_resultController.text),
        );

        if (_resultController.text.endsWith(".0")) {
          _resultController.text = _resultController.text.substring(
            0,
            _resultController.text.indexOf(Btn.dot),
          );
        }
      } else {
        _resultController.text = "";
      }
    } on FormatException catch (e) {
      // Catching a specific type
      print("Caught ArgumentError: $e");
      if (e.toString().contains("Bad expression:")) {
        displayError("Use ${Btn.multiply} for multiplication AFTER bracket.");

        int countlbrack = e.toString().split(Btn.lbrack).length - 1;
        int countrbrack = e.toString().split(Btn.rbrack).length - 1;
        if (countlbrack != countrbrack) {
          displayError("Unbalanced Brackets");
        } else if (RegExp(r"\)\d+|\d+\(").hasMatch(e.toString())) {
          displayError("Use ${Btn.multiply} for multiplication AFTER bracket.");
        }
      }
    } catch (e) {
      print("Error in update_resultController: $e");
    }
  }

  String conversion(String text) {
    text = text.replaceAll("×", "*");
    text = text.replaceAll("÷", "/");
    return text;
  }
}
