import 'package:example/card_view.dart';
import 'package:flutter/material.dart';
import 'package:swipeable_cards_stack/swipeable_cards_stack.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int counter = 4;
  final cardController = SwipeableCardsStackController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SwipeableCardsStack(
            cardController: cardController,
            context: context,
            //add the first 3 cards
            items: const [
              CardView(text: "First card"),
              CardView(text: "Second card"),
              CardView(text: "Third card"),
            ],
            onCardSwiped: (dir, index, widget) {
              //Add the next card
              if (counter <= 20) {
                cardController.addItem(CardView(text: "Card $counter"));
                counter++;
              }

              if (dir == AxisDirection.left) {
                debugPrint('onDisliked ${(widget as CardView).text} $index');
              } else if (dir == AxisDirection.right) {
                debugPrint('onLiked ${(widget as CardView).text} $index');
              } else if (dir == AxisDirection.up) {
                debugPrint('onUp ${(widget as CardView).text} $index');
              } else if (dir == AxisDirection.down) {
                debugPrint('onDown ${(widget as CardView).text} $index');
              }
            },
            enableSwipeUp: true,
            enableSwipeDown: true,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  child: const Icon(Icons.chevron_left),
                  onPressed: () => cardController.triggerSwipeLeft(),
                ),
                FloatingActionButton(
                  child: const Icon(Icons.chevron_right),
                  onPressed: () => cardController.triggerSwipeRight(),
                ),
                FloatingActionButton(
                  child: const Icon(Icons.arrow_upward),
                  onPressed: () => cardController.triggerSwipeUp(),
                ),
                FloatingActionButton(
                  child: const Icon(Icons.arrow_downward),
                  onPressed: () => cardController.triggerSwipeDown(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
