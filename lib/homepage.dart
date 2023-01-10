import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCoinData();
  }

  String selectedCurrency = 'INR';
  double bitcoinPrice = 0;
  double ethereumPrice = 0;
  double litcoinPrice = 0;
  String apiKey = 'E0FFE2E3-1EAC-4FA5-978B-4B2F12DC233C';
  String baseURL =
      'https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=E0FFE2E3-1EAC-4FA5-978B-4B2F12DC233C';

  //Function to get Coin data ->

  void getCoinData() async {
    http.Response bitcoin = await http.get(
      Uri.parse(
          'https://rest.coinapi.io/v1/exchangerate/BTC/$selectedCurrency?apikey=E0FFE2E3-1EAC-4FA5-978B-4B2F12DC233C'),
    );
    final body = jsonDecode(bitcoin.body);
    setState(() {
      bitcoinPrice = body['rate'];
    });

    http.Response ethereum = await http.get(
      Uri.parse(
          'https://rest.coinapi.io/v1/exchangerate/ETH/$selectedCurrency?apikey=E0FFE2E3-1EAC-4FA5-978B-4B2F12DC233C'),
    );
    final body1 = jsonDecode(ethereum.body);
    setState(() {
      ethereumPrice = body1['rate'];
    });
    http.Response litcoin = await http.get(
      Uri.parse(
          'https://rest.coinapi.io/v1/exchangerate/LTC/$selectedCurrency?apikey=E0FFE2E3-1EAC-4FA5-978B-4B2F12DC233C'),
    );
    final body2 = jsonDecode(litcoin.body);
    setState(() {
      litcoinPrice = body2['rate'];
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crypto Tracker'),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Container(
                      height: height * 0.1,
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '1 BTC = ${bitcoinPrice.toStringAsFixed(4)}  $selectedCurrency',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Container(
                      height: height * 0.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '1 ETH = ${ethereumPrice.toStringAsFixed(4)}  $selectedCurrency',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Container(
                      height: height * 0.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '1 LTC = ${litcoinPrice.toStringAsFixed(4)}  $selectedCurrency',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: width,
              height: height * 0.2,
              color: Colors.lightBlueAccent.shade700,
              child: Center(
                child: DropdownButton<String>(
                  value: selectedCurrency,
                  items: getDropDownItems(),
                  onChanged: (value) {
                    setState(() {
                      selectedCurrency = value ?? 'INR';
                      getCoinData();
                    });
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  getDropDownItems() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String currency in currencies) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDownItems.add(newItem);
    }
    return dropDownItems;
  }
}
