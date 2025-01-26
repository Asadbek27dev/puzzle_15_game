import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/game_bloc.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final bloc = GameBloc()..add(const GameEvent.newGame());

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  List<int> trueList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 0];

  Color trueColor({required int model}) {
    print(model);
    Color color = Colors.black;
    for (var i = 0; i < trueList.length; i++) {
      if (model == trueList[i]) {
        color = Colors.black;
      } else {
        color = Color(0xFF03fcf8);
      }
    }
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocListener<GameBloc, GameState>(
        listener: (context, state) {
          if (state.finished) {
            print("FINISHED");
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    width: 320,
                    height: 200,
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Excellent!',
                          style: TextStyle(
                              fontSize: 37,
                              color: Color.fromRGBO(87, 64, 124, 1),
                              fontFamily: "Pacifico"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "It took you  ",
                              style: TextStyle(
                                color: Color.fromRGBO(83, 70, 72, 1),
                              ),
                            ),
                            Text(
                              "${state.count} moves",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(83, 70, 72, 1),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 16),
                        MaterialButton(
                          onPressed: () {
                            bloc.add(const GameEvent.newGame());
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            width: 290,
                            height: 62,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color.fromRGBO(61, 41, 99, 1),
                            ),
                            child: Center(
                              child: Text(
                                "Play Again",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
        child: BlocBuilder<GameBloc, GameState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                  title: Center(
                child: const Text(
                  "15 Puzzle",
                  style: TextStyle(
                      fontSize: 40,
                      fontFamily: "Pacifico",
                      color: Colors.deepPurple),
                ),
              )),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            bloc.add(const GameEvent.newGame());
                          },
                          child: Container(
                            width: 150,
                            height: 62,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color.fromRGBO(61, 41, 99, 1),
                            ),
                            child: Center(
                              child: const Text(
                                "new game",
                                style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 0.5),
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 192,
                          height: 62,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color.fromRGBO(61, 41, 99, 1),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "TIME",
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                  Text(
                                    "  ${state.count}s",
                                    style: const TextStyle(
                                        fontSize: 21,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "MOVES",
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                  Text(
                                    "  ${state.count}",
                                    style: const TextStyle(
                                        fontSize: 21,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      itemCount: state.list.length,
                      padding: const EdgeInsets.all(10),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemBuilder: (_, i) {
                        final model = state.list[i];
                        if (model == 0) {
                          // ignore: deprecated_member_use
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              // ignore: deprecated_member_use
                              color: Colors.blue.withOpacity(0.2),
                            ),
                          );
                        }
                        return GestureDetector(
                          onTap: () => bloc.add(GameEvent.onTap(i)),
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: trueColor(model: model),
                            ),
                            child: Text(
                              "$model",
                              style: const TextStyle(
                                fontFamily: "Pacifico",
                                fontSize: 45,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                shadows: [
                                  Shadow(
                                    blurRadius: 1.0,
                                    color: Colors.grey,
                                    offset: Offset(3.0, 3.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
