import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/game_bloc.dart';
import "package:flutter_screenutil/flutter_screenutil.dart";

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

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocListener<GameBloc, GameState>(
        listener: (context, state) {
          if (state.finished) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Container(
                    width: 320.w,
                    height: 200.h,
                    padding: EdgeInsets.all(16.r),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Excellent!',
                          style: TextStyle(
                              fontSize: 37.sp,
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
                        SizedBox(height: 16.h),
                        MaterialButton(
                          onPressed: () {
                            bloc.add(const GameEvent.newGame());
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            width: 290.w,
                            height: 62.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: Color.fromRGBO(61, 41, 99, 1),
                            ),
                            child: Center(
                              child: Text(
                                "Play Again",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.sp,
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
                child: Text(
                  "15 Puzzle",
                  style: TextStyle(
                      fontSize: 40.sp,
                      fontFamily: "Pacifico",
                      color: Colors.deepPurple),
                ),
              )),
              body: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            bloc.add(const GameEvent.newGame());
                          },
                          child: Container(
                            width: 150.w,
                            height: 62.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: Color.fromRGBO(61, 41, 99, 1),
                            ),
                            child: Center(
                              child: Text(
                                "new game",
                                style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 0.5),
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 192.w,
                          height: 62.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
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
                                    style: TextStyle(
                                        fontSize: 12.sp, color: Colors.white),
                                  ),
                                  Text(
                                    "  ${state.count}s",
                                    style: TextStyle(
                                        fontSize: 21.sp,
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
                                    style: TextStyle(
                                        fontSize: 12.sp, color: Colors.white),
                                  ),
                                  Text(
                                    "  ${state.count}",
                                    style: TextStyle(
                                        fontSize: 21.sp,
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
                      padding: EdgeInsets.all(10.r),
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
                              borderRadius: BorderRadius.circular(12.r),
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
                              borderRadius: BorderRadius.circular(12.r),
                              color: Colors.white,
                            ),
                            child: Text(
                              "$model",
                              style: TextStyle(
                                fontFamily: "Pacifico",
                                fontSize: 45.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                shadows: [
                                  Shadow(
                                    blurRadius: 1.0.r,
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
                  SizedBox(height: 40.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
