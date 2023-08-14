import 'package:amigos_de_merda/firstpage.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'cardpage.dart';

class ChoicePage extends StatefulWidget {
  const ChoicePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChoicePageState createState() => _ChoicePageState();
}

class _ChoicePageState extends State<ChoicePage> {
  int _numberOfPlayers = 3;
  int _numberOfCards = 3;
  List<TextEditingController> _controllers = [];

  List<String> _playerNames = [];

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(
      _numberOfPlayers,
      (_) => TextEditingController(),
    );

    _playerNames = List.generate(_numberOfPlayers, (_) => '');
  }

  @override
  void dispose() {
    _controllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 8.h, left: 5.w, right: 5.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton<int>(
                      value: _numberOfPlayers,
                      onChanged: (value) {
                        setState(() {
                          _numberOfPlayers = value!;
                          _controllers.clear();
                          _playerNames.clear();
                          _controllers = List.generate(
                            _numberOfPlayers,
                            (_) => TextEditingController(),
                          );
                          _playerNames =
                              List.generate(_numberOfPlayers, (_) => '');
                        });
                      },
                      items: List.generate(8, (index) {
                        int numberOfPlayers = index + 3;
                        return DropdownMenuItem(
                          value: numberOfPlayers,
                          child: Text('$numberOfPlayers jogadores'),
                        );
                      }),
                    ),
                    DropdownButton<int>(
                      value: _numberOfCards,
                      onChanged: (value) {
                        setState(() {
                          _numberOfCards = value!;
                        });
                      },
                      items: List.generate(8, (index) {
                        int _numberOfCards = index + 3;
                        return DropdownMenuItem(
                          value: _numberOfCards,
                          child: Text('Nº de Cartas: $_numberOfCards '),
                        );
                      }),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                const Text('Nomes dos jogadores:'),
                const SizedBox(height: 8.0),
                // ignore: sized_box_for_whitespace
                Container(
                  height: 60.h, // Altura fixa do ListView
                  child: ListView.builder(
                    itemCount: _numberOfPlayers,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 80.w,
                            child: TextField(
                              controller: _controllers[index],
                              decoration: InputDecoration(
                                labelText: 'Jogador ${index + 1}',
                              ),
                              onChanged: (value) {
                                _playerNames[index] = value;
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.red)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const FirstPage()));
                        },
                        child: const Text('Voltar')),
                    ElevatedButton(
                      onPressed: () {
                        _playerNames
                            .removeWhere((element) => element.trim().isEmpty);
                        if (_playerNames.length >= 3) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CardPage(
                                        listOfPlayers: _playerNames,
                                        numberOfCards: _numberOfCards,
                                      )));
                        } else {
                          setState(() {
                            _controllers.clear();
                            _playerNames.clear();
                            _controllers = List.generate(
                              _numberOfPlayers,
                              (_) => TextEditingController(),
                            );
                            _playerNames =
                                List.generate(_numberOfPlayers, (_) => '');
                          });
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                                'Preencha o nome de pelo menos 3 jogadores',
                                textAlign: TextAlign.center),
                            duration: Duration(seconds: 2),
                          ));
                        }
                      },
                      child: const Text('Jogar'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
