import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'choice.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/background.jpg'),
              fit: BoxFit.cover,
            )),
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChoicePage()));
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.black)),
                    child: Text('Novo Jogo')),
                SizedBox(
                  height: 2.h,
                ),
                ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'Como Jogar?',
                              textAlign: TextAlign.center,
                            ),
                            content: Container(
                                width: double.maxFinite,
                                child: Text(
                                    'Vire uma carta, conte até 3 e apontem simultaneamente para quem voces acham que combina mais com aquela condição, aquele que tiver mais pontos vence')),
                            actions: <Widget>[
                              ElevatedButton(
                                child: Text('Fechar'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.black)),
                    child: Text('Como Jogar?')),
                SizedBox(
                  height: 2.h,
                ),
                ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'Somos a Docasgoon',
                              textAlign: TextAlign.center,
                            ),
                            content: SingleChildScrollView(
                              child: Container(
                                  width: double.maxFinite,
                                  child: Column(
                                    children: [
                                      Text(
                                        'Bem-vindos à Docasgoon, uma empresa indie de jogos formada por dois programadores apaixonados por criar experiências incríveis. Combinamos programação e paixão por jogos para desenvolver títulos únicos e divertidos. Com sua ajuda, continuaremos a criar jogos cativantes e divertidos. Junte-se a nós nessa jornada! \n\nAjude-nos com feedback ou financeiramente. Nosso email de contato também é nossa Pix caso deseje fazer alguma doação: ',
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 2.h),
                                        child: Text(
                                          'docasgoon@docasgoon.com',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                child: Text('Fechar'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.black)),
                    child: Text('Sobre nós'))
              ],
            )),
      );
    });
  }
}
