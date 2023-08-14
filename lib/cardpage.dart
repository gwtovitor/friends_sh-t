import 'package:amigos_de_merda/choice.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:math';

class CardPage extends StatefulWidget {
  final List<String> listOfPlayers;
  final int numberOfCards;
  const CardPage(
      {super.key, required this.numberOfCards, required this.listOfPlayers});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  FlipCardController controller = FlipCardController();
  bool isFront = false;
  List cardlist = [];
  int indice = 0;
  late final List<String> _listOfPlayers;
  late final int _numberOfCards;
  List playerPoints = [];

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
    _listOfPlayers = widget.listOfPlayers;
    _numberOfCards = widget.numberOfCards;
    main();
    criacaoLista();
    controller = FlipCardController();
  }

  void criacaoLista() {
    List<Map<String, dynamic>> listOfPlayersWithScore = [];
    List<String> nomesJogadores = widget.listOfPlayers;
    for (var player in nomesJogadores) {
      listOfPlayersWithScore.add({'name': player, 'score': 0});
    }
    setState(() {
      playerPoints = listOfPlayersWithScore;
    });
  }

  addPointsToPlayer(index) {
    setState(() {
      playerPoints[index]['score']++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover,
          )),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Container(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(top: 5.h, right: 2.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                    'Pontuações dos Jogadores',
                                    textAlign: TextAlign.center,
                                  ),
                                  content: Container(
                                    width: double.maxFinite,
                                    child: ListView.builder(
                                      itemCount: playerPoints.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        var player =
                                            playerPoints[index]['name'];
                                        return ListTile(
                                          title:
                                              Text(playerPoints[index]['name']),
                                          trailing: Text(
                                              '${playerPoints[index]['score']} pontos'),
                                          onTap: () {},
                                        );
                                      },
                                    ),
                                  ),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      child: const Text('Fechar'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: const Text('Pontuação'),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 2.w),
                          child: ElevatedButton(
                              style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.red)),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ChoicePage()));
                              },
                              child: const Text('Voltar')),
                        ),
                      ],
                    ),
                  )),
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: SizedBox(
                  width: 70.w,
                  height: 50.h,
                  child: Card(
                    elevation: 0.0,
                    margin: const EdgeInsets.only(
                        left: 32.0, right: 32.0, top: 20.0, bottom: 0.0),
                    color: const Color(0x00000000),
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
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0)),
                            border: Border.all(
                              color: Colors.black,
                              width: 2.0,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(0.5.h),
                            child: Container(
                                color: Colors.black,
                                child: Padding(
                                  padding: EdgeInsets.all(0.5.h),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.white),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          width:
                                              25.h, // Define a largura desejada
                                          height:
                                              25.h, // Define a altura desejada
                                          child: Image.asset(
                                              'assets/backgroundcard.jpg'),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          )),
                      back: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(1.h),
                            child: Container(
                              decoration:
                                  const BoxDecoration(color: Colors.black),
                              child: Padding(
                                padding: EdgeInsets.all(0.5.h),
                                child: Container(
                                  decoration:
                                      const BoxDecoration(color: Colors.white),
                                  child: Padding(
                                    padding: EdgeInsets.all(2.h),
                                    child: Column(
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(8.0),
                                                  topRight:
                                                      Radius.circular(8.0)),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                            flex: 3,
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                              ),
                                              child: FutureBuilder(
                                                builder: (context, snapshot) {
                                                  return Container(
                                                    height: double.infinity,
                                                    width: double.infinity,
                                                    child: Center(
                                                      child: Text(
                                                        cardlist[indice]
                                                            ['frase'],
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            )),
                                        Flexible(
                                          flex: 1,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(8.0),
                                                  bottomRight:
                                                      Radius.circular(8.0)),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.red)),
                            onPressed: () {
                              controller.toggleCard();
                              indice++;
                              if (indice == cardlist.length) {
                                indice = 0;
                              }
                            },
                            child: const Text('Descartar'))
                        : null,
                  ),
                  SizedBox(width: 1.w),
                  SizedBox(
                    child: isFront
                        ? ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.green)),
                            onPressed: () {
                              controller.toggleCard();

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title:
                                        const Text('Pontuações dos Jogadores'),
                                    content: Container(
                                      width: double.maxFinite,
                                      child: ListView.builder(
                                        itemCount: playerPoints.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          var player =
                                              playerPoints[index]['name'];
                                          return ListTile(
                                            title: Text(
                                                playerPoints[index]['name']),
                                            trailing: Text(
                                                '${playerPoints[index]['score']} pontos'),
                                            onTap: () {
                                              print(_numberOfCards);
                                              if (playerPoints[index]
                                                      ['score'] ==
                                                  _numberOfCards - 1) {
                                                var vencedor =
                                                    playerPoints[index]['name'];
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          'Vencedor'),
                                                      content: Text(
                                                          '$vencedor é o friendsh!t'),
                                                      alignment:
                                                          Alignment.center,
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .popUntil(ModalRoute
                                                                    .withName(
                                                                        '/'));
                                                          },
                                                          child: const Text(
                                                              'Voltar ao menu'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              } else {
                                                addPointsToPlayer(index);
                                                Navigator.of(context).pop();
                                                indice++;
                                                if (indice == cardlist.length) {
                                                  indice = 0;
                                                }
                                              }
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        child: const Text('Fechar'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: const Text('Quem venceu a rodada?'))
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
