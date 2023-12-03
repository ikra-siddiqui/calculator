import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  dynamic displaytxt = 20;
  Widget calButton(String btntxt, Color btncolor, Color txtcolor) {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          calculation(btntxt);
        },
        child: Text(
          '$btntxt',
          style: TextStyle(fontSize: 35, color: txtcolor),
        ),
        style: ElevatedButton.styleFrom(
            shape: const CircleBorder(), //<-- SEE HERE
            padding: const EdgeInsets.all(20),
            backgroundColor: btncolor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  '$text',
                  textAlign: TextAlign.left,
                  style: const TextStyle(color: Colors.white, fontSize: 100),
                ),
              )
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calButton("AC", Colors.grey, Colors.black),
                calButton("+/-", Colors.grey, Colors.black),
                calButton("%", Colors.grey, Colors.black),
                calButton("/", Colors.amber, Colors.white)
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calButton("7", Colors.grey[850]!, Colors.white),
                calButton("8", Colors.grey[850]!, Colors.white),
                calButton("9", Colors.grey[850]!, Colors.white),
                calButton("×", Colors.amber, Colors.white)
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calButton("4", Colors.grey[850]!, Colors.white),
                calButton("5", Colors.grey[850]!, Colors.white),
                calButton("6", Colors.grey[850]!, Colors.white),
                calButton("-", Colors.amber, Colors.white)
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calButton("1", Colors.grey[850]!, Colors.white),
                calButton("2", Colors.grey[850]!, Colors.white),
                calButton("3", Colors.grey[850]!, Colors.white),
                calButton("+", Colors.amber, Colors.white)
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    calculation('0');
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(), //<-- SEE HERE
                    padding: const EdgeInsets.fromLTRB(45, 20, 128, 20),
                    backgroundColor: Colors.grey[850],
                  ),
                  child: const Text(
                    '0',
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                calButton('.', Colors.grey[850]!, Colors.white),
                const SizedBox(
                  width: 20,
                ),
                calButton('=', Colors.grey[700]!, Colors.white),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  dynamic text = '0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
  void calculation(btnText) {
    if (btnText == 'AC') {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && btnText == '=') {
      if (preOpr == '+') {
        finalResult = add();
      } else if (preOpr == '-') {
        finalResult = sub();
      } else if (preOpr == 'x') {
        finalResult = mul();
      } else if (preOpr == '/') {
        finalResult = div();
      }
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == 'x' ||
        btnText == '/' ||
        btnText == '=') {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == 'x') {
        finalResult = mul();
      } else if (opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    } else if (btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if (btnText == '.') {
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';

      }
      
      finalResult = result;
    } else if (btnText == '+/-') {
      result.toString().startsWith('-')
          ? result = result.toString().substring(1)
          : result = '-' + result.toString();
      finalResult = result;
    } else {
      result = result + btnText;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    if (numTwo == 0) {
      // Handle division by zero scenario
      return "Error"; // You can return an error message or handle it as needed
    } else {
      result = (numOne / numTwo).toString();
      numOne = double.parse(result);
      return doesContainDecimal(result);
    }
    // result = (numOne / numTwo).toString();
    // numOne = double.parse(result);
    // return doesContainDecimal(result);
  }

  String sanitizeString(String input) {
    // Remove all non-numeric characters except for the dot
    String sanitized = input.replaceAll(RegExp(r'[^0-9.]'), '');
    return sanitized;
  }

  String doesContainDecimal(dynamic result) {
    String sanitizedResult = sanitizeString(result.toString());

    if (sanitizedResult.contains('.')) {
      List<String> splitDecimal = sanitizedResult.split('.');
      if (!(int.tryParse(splitDecimal[1]) != null &&
          int.parse(splitDecimal[1]) > 0)) {
        return splitDecimal[0].toString();
      }
    }
    return sanitizedResult;
  }
  // String doesContainDecimal(dynamic result) {
  //   if (result.toString().contains('.')) {
  //     List<String> splitDecimal = result.toString().split('.');
  //     if (!(int.parse(splitDecimal[1]) > 0))
  //       return result = splitDecimal[0].toString();
  //   }
  //   return result;
  // }
}
