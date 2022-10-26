import 'dart:convert';

import 'package:apitrial/main.dart';
import 'package:apitrial/number_fact_response/number_fact_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<NumberFactResponse> getNumberFact({required String number}) async {
  final _response = await http.get(
    Uri.parse("http://numbersapi.com/$number?json"),
  );
  print(_response.body);

  final _bodyAsJson = jsonDecode(_response.body) as Map<String, dynamic>;
  //print(_bodyAsJson);
  final _data = NumberFactResponse.fromJson(_bodyAsJson);
  return _data;
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _textController = TextEditingController();

  String _resultText = 'Type number and press Get Result ';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Api Testing')),
        body: Column(
          children: [
            const SizedBox(
              height: 12,
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  hintText: "Type in your text",
                ),
                controller: _textController,
                keyboardType: TextInputType.number,
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final result =
                      await getNumberFact(number: _textController.text);
                  print(result.text);

                  setState(() {
                    _resultText = result.text??'No Text Found';
                  });
                },
                child: const Text('GET RESULT'),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            // ignore: unnecessary_string_interpolations
            //   newMethod(),
            Text(_resultText),
          ],
        ));
  }
}
