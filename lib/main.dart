import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Interest Calculator',
      home: SIForm(),
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.indigo,
          accentColor: Colors.indigoAccent)));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  var _formKey = GlobalKey<FormState>();


  var _currencies = ['pounds', 'naira', 'rupees'];
  final _minimumPadding = 5.0;

  var _currenciesSelected = '';

  @override
  void initState() {
    super.initState();
    _currenciesSelected = _currencies[0];
  }

  var displayResult = '';

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline6;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Simple Interest Calculator'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.all(_minimumPadding * 2),
            child: ListView(
              children: <Widget>[
                getImageAsset(),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      style: textStyle,
                      controller: principalController,
                      validator: (String value){
                        if (value.isEmpty){
                          return 'Please enter Principal Amount';
                        }
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(
                          color: Colors.yellowAccent,
                          fontSize: 15.0
                        ),
                          labelText: 'Principal',
                          labelStyle: textStyle,
                          hintText: 'Enter Principal e.g. 12000',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      style: textStyle,
                      controller: roiController,
                      validator: (String value){
                        if (value.isEmpty){
                          return 'Please enter Rate of Interest';
                        }
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          errorStyle: TextStyle(
                              color: Colors.yellowAccent,
                              fontSize: 15.0
                          ),
                          labelText: 'Rate of Interest',
                          labelStyle: textStyle,
                          hintText: 'Enter Rate of Interest in percent',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                    )),
                Padding(
                  padding: EdgeInsets.only(
                      top: _minimumPadding, bottom: _minimumPadding),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          style: textStyle,
                          controller: termController,
                          validator: (String value){
                            if (value.isEmpty){
                              return 'Please enter Time';
                            }
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              errorStyle: TextStyle(
                                  color: Colors.yellowAccent,
                                  fontSize: 15.0
                              ),
                              labelText: 'Time',
                              labelStyle: textStyle,
                              hintText: 'Time in years',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                        ),
                      ),
                      Container(
                        width: _minimumPadding * 5,
                      ),
                      Expanded(
                        child: DropdownButton<String>(
                          items: _currencies.map(
                            (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                          value: _currenciesSelected,
                          onChanged: (String newValueSelected) {
                            _onDropDownItemSelected(newValueSelected);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        bottom: _minimumPadding, top: _minimumPadding),
                    child: Row(
                      children: [
                        Expanded(
                          child: RaisedButton(
                            color: Theme.of(context).accentColor,
                            textColor: Theme.of(context).primaryColor,
                            child: Text(
                              'Calculate',
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {

                              setState(() {
                                if (_formKey.currentState.validate()) {
                                  this.displayResult = _calculateTotalReturn();
                                }
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RaisedButton(
                            color: Theme.of(context).primaryColorDark,
                            textColor: Theme.of(context).primaryColorLight,
                            child: Text(
                              'Reset',
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              setState(() {
                                _reset();
                              });
                            },
                          ),
                        )
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.all(_minimumPadding * 2),
                  child: Text(
                    this.displayResult,
                    style: textStyle,
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/houseicon1.png');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );

    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumPadding * 10),
    );
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currenciesSelected = newValueSelected;
    });
  }

  String _calculateTotalReturn() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double totalAmountPayable = principal + (principal * roi * term) / 100;
    String result =
        'After $term years, your investment will be worth $totalAmountPayable $_currenciesSelected';
    return result;
  }

  void _reset() {
    principalController.text = '';
    roiController.text = '';
    termController.text = '';
    displayResult = '';
    _currenciesSelected = _currencies[0];
  }
}
