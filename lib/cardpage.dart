import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:math';

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  FlipCardController controller = FlipCardController();
  bool isFront = false;
  List cardlist = [];
  var indice = 0;
  Future<String> carregaJson() async {
    // Carrega o conteúdo do arquivo JSON como uma String
    String jsonString = await rootBundle.loadString('assets/cards.json');

    // Decodifica o JSON
    final jsonDecodificado = json.decode(jsonString);

    // Retorna o JSON decodificado como um objeto
    return jsonEncode(jsonDecodificado);
  }

  void main() async {
    // Carrega o JSON
    var jsonString = await carregaJson();

    // Decodifica o JSON em uma lista
    List<dynamic> listaJson = json.decode(jsonString);

    // Embaralha a lista
    listaJson.shuffle(Random());
    setState(() {
      cardlist = listaJson;
    });
  }

  @override
  void initState() {
    super.initState();
    main();
    controller = FlipCardController();
  }

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
            children: [
              Padding(
                padding: EdgeInsets.only(top: 23.h),
                child: SizedBox(
                  width: 70.w,
                  height: 50.h,
                  child: Card(
                    elevation: 0.0,
                    margin: EdgeInsets.only(
                        left: 32.0, right: 32.0, top: 20.0, bottom: 0.0),
                    color: Color(0x00000000),
                    child: FlipCard(
                      controller: controller,
                      direction: FlipDirection.HORIZONTAL,
                      side: CardSide.FRONT,
                      speed: 1000,
                      onFlipDone: (status) {
                        setState(() {
                          isFront = status;
                        });
                      },
                      front: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset('assets/backgroundcard.png'),
                          ],
                        ),
                      ),
                      back: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          child: Column(
                            children: [
                              Flexible(
                                flex: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8.0),
                                        topRight: Radius.circular(8.0)),
                                  ),
                                ),
                              ),
                              Flexible(
                                  flex: 3,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: FutureBuilder(
                                      builder: (context, snapshot) {
                                        return Container(
                                          height: double.infinity,
                                          width: double.infinity,
                                          child: Center(
                                            child: Text(
                                              cardlist[indice]['frase'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w800),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )),
                              Flexible(
                                flex: 1,
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(8.0),
                                          bottomRight: Radius.circular(8.0)),
                                    ),
                                    child: Container(
                                        width: double.infinity,
                                        height: double.infinity,
                                        child: Center(
                                          child: Text(
                                            'Autor: ' +
                                                cardlist[indice]['autor'] +
                                                '',
                                            style: TextStyle(
                                                fontSize: 7.sp,
                                                color: Colors.white),
                                          ),
                                        ))),
                              )
                            ],
                          )),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              SizedBox(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: isFront
                        ? ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.red)),
                            onPressed: () {
                              controller.toggleCard();
                              indice++;
                              if (indice == cardlist.length) {
                                indice = 0;
                              }
                            },
                            child: Text('Descartar'))
                        : null,
                  ),
                  SizedBox(width: 1.w),
                  SizedBox(
                    child: isFront
                        ? ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.green)),
                            onPressed: () {
                              controller.toggleCard();
                            },
                            child: Text('Quem venceu?'))
                        : null,
                  )
                ],
              ))
            ],
          ),
        ),
      );
    });
  }
}
