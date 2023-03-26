import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 250,
              height: 350,
              child: Card(
                elevation: 0.0,
                margin: EdgeInsets.only(
                    left: 32.0, right: 32.0, top: 20.0, bottom: 0.0),
                color: Color(0x00000000),
                child: FlipCard(
                  direction: FlipDirection.HORIZONTAL,
                  side: CardSide.FRONT,
                  speed: 1000,
                  onFlipDone: (status) {
                    print(status);
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
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Conteudo da primeira Carta',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
