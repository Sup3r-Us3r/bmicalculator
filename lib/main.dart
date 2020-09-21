import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(title: 'Calc IMC', home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  String _info = 'Informe seus dados';

  void _resetFields() {
    weightController.text = '';
    heightController.text = '';

    setState(() {
      _info = 'Informe seus dados';
    });
  }

  void _calculate() {
    setState(() {
      double height = double.parse(heightController.text) / 100;
      double weight = double.parse(weightController.text);
      double imc = weight / (height * height);

      if (imc < 18.6) {
        _info = 'Abaixo do peso - IMC ${imc.toStringAsPrecision(3)}';
      } else if (imc >= 18.6 && imc < 24.9) {
        _info = 'Peso ideal - IMC ${imc.toStringAsPrecision(3)}';
      } else if (imc >= 24.9 && imc < 29.9) {
        _info = 'Levemente acima do peso - IMC ${imc.toStringAsPrecision(3)}';
      } else if (imc >= 29.9 && imc < 34.9) {
        _info = 'Obesidade grau I - IMC ${imc.toStringAsPrecision(3)}';
      } else if (imc >= 34.9 && imc < 39.9) {
        _info = 'Obsesidade grau II - IMC ${imc.toStringAsPrecision(3)}';
      } else if (imc >= 40) {
        _info = 'Obesidade grau III - IMC ${imc.toStringAsPrecision(3)}';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calculadora IMC'),
          centerTitle: true,
          actions: [
            IconButton(icon: Icon(Icons.refresh), onPressed: _resetFields),
          ],
          backgroundColor: Colors.purpleAccent[700],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(Icons.assessment,
                    size: 100, color: Colors.purpleAccent[700]),
                Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.purpleAccent[700], width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          labelText: 'Peso (KG)',
                          labelStyle: TextStyle(
                              color: Colors.purpleAccent[700], fontSize: 18)),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                      maxLength: 3,
                      controller: weightController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Insira seu peso!';
                        }
                      },
                    )),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.purpleAccent[700], width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      labelText: 'Altura (CM)',
                      labelStyle: TextStyle(
                          color: Colors.purpleAccent[700], fontSize: 16)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 23),
                  maxLength: 3,
                  controller: heightController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Insira sua altura!';
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Container(
                    height: 50,
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          return _calculate();
                        }
                      },
                      color: Colors.purpleAccent[700],
                      child: Text(
                        'Calcular',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ),
                Text(_info,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.purpleAccent[700], fontSize: 16)),
              ],
            ),
          ),
        ));
  }
}
