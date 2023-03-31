import 'package:SudokuSolver/blocs/sudoku_bloc.dart';
import 'package:SudokuSolver/widgets/example_button.dart';
import 'package:SudokuSolver/widgets/grid_tile.dart';
import 'package:SudokuSolver/widgets/reset_button.dart';
import 'package:SudokuSolver/widgets/title_text.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedX = 0;
  int selectedY = 0;
  final SudokuBloc _sudokuBloc = SudokuBloc();
  @override
  void dispose() {
    _sudokuBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1B2023),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: StreamBuilder<List<List<int>>>(
            stream: _sudokuBloc.sudokuGridStream,
            builder: (BuildContext context,
                AsyncSnapshot<List<List<int>>> snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }
              return SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // SizedBox(height: 60),
                    TitleText(),
                    // SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _sudokuBloc.changeGridSink.add([
                              [0, 0, 0, 0, 0, 0, 0, 0, 0],
                              [0, 0, 0, 0, 0, 0, 0, 0, 0],
                              [0, 0, 0, 0, 0, 0, 0, 0, 0],
                              [0, 0, 0, 0, 0, 0, 0, 0, 0],
                              [0, 0, 0, 0, 0, 0, 0, 0, 0],
                              [0, 0, 0, 0, 0, 0, 0, 0, 0],
                              [0, 0, 0, 0, 0, 0, 0, 0, 0],
                              [0, 0, 0, 0, 0, 0, 0, 0, 0],
                              [0, 0, 0, 0, 0, 0, 0, 0, 0]
                            ]);
                          },
                          child: ResetButton(),
                        ),
                        GestureDetector(
                          onTap: () {
                            _sudokuBloc.changeGridSink.add([
                              [5, 3, 0, 0, 7, 0, 0, 1, 0],
                              [6, 0, 0, 1, 9, 5, 0, 0, 8],
                              [0, 9, 8, 0, 0, 0, 5, 6, 0],
                              [8, 0, 0, 7, 6, 0, 0, 2, 3],
                              [4, 0, 0, 8, 0, 3, 0, 0, 1],
                              [7, 0, 0, 0, 2, 0, 0, 0, 6],
                              [9, 6, 0, 5, 0, 0, 2, 8, 0],
                              [0, 0, 0, 4, 1, 9, 0, 0, 5],
                              [0, 0, 5, 0, 8, 0, 0, 7, 9]
                            ]);
                          },
                          child: ExampleButton(),
                        ),
                      ],
                    ),
                    // SizedBox(height: 40),
                    Container(
                      padding: EdgeInsets.all(3.5),
                      height: 296,
                      width: 296,
                      color: Color(0xff575D62),
                      child: GridView.builder(
                        itemCount: 81,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 9,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          int i = (index % 9);
                          int j = (index ~/ 9);
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedX = i;
                                selectedY = j;
                              });
                            },
                            child: SudokuTile(
                              c: (i == selectedX && j == selectedY)
                                  ? Colors.grey
                                  : (((i + 1 <= 6 && i + 1 >= 4) &&
                                              (j + 1 <= 3 || j + 1 >= 7)) ||
                                          ((i + 1 <= 3 || i + 1 >= 7) &&
                                              (j + 1 >= 4 && j + 1 <= 6))
                                      ? Color(0xff1B2023)
                                      : Color(0xff23292C)),
                              value: snapshot.data[j][i],
                            ),
                          );
                        },
                      ),
                    ),
                    // SizedBox(height: 35),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _sudokuBloc.changeValue
                                    .add([selectedX, selectedY, 0]);
                              },
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'C',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "Sofia-Pro",
                                      color: Color(0xffB7B7B7),
                                    ),
                                  ),
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: (snapshot.data[selectedY]
                                                [selectedX] ==
                                            0)
                                        ? Colors.grey
                                        : Color(0xff2D2D2D),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _sudokuBloc.changeValue
                                    .add([selectedX, selectedY, 1]);
                              },
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '1',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "Sofia-Pro",
                                      color: Color(0xffB7B7B7),
                                    ),
                                  ),
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: (snapshot.data[selectedY]
                                                [selectedX] ==
                                            1)
                                        ? Colors.grey
                                        : Color(0xff2D2D2D),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _sudokuBloc.changeValue
                                    .add([selectedX, selectedY, 2]);
                              },
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '2',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "Sofia-Pro",
                                      color: Color(0xffB7B7B7),
                                    ),
                                  ),
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: (snapshot.data[selectedY]
                                                [selectedX] ==
                                            2)
                                        ? Colors.grey
                                        : Color(0xff2D2D2D),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _sudokuBloc.changeValue
                                    .add([selectedX, selectedY, 3]);
                              },
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '3',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "Sofia-Pro",
                                      color: Color(0xffB7B7B7),
                                    ),
                                  ),
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: (snapshot.data[selectedY]
                                                [selectedX] ==
                                            3)
                                        ? Colors.grey
                                        : Color(0xff2D2D2D),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _sudokuBloc.changeValue
                                    .add([selectedX, selectedY, 4]);
                              },
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '4',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "Sofia-Pro",
                                      color: Color(0xffB7B7B7),
                                    ),
                                  ),
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: (snapshot.data[selectedY]
                                                [selectedX] ==
                                            4)
                                        ? Colors.grey
                                        : Color(0xff2D2D2D),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _sudokuBloc.changeValue
                                    .add([selectedX, selectedY, 5]);
                              },
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '5',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "Sofia-Pro",
                                      color: Color(0xffB7B7B7),
                                    ),
                                  ),
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: (snapshot.data[selectedY]
                                                [selectedX] ==
                                            5)
                                        ? Colors.grey
                                        : Color(0xff2D2D2D),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _sudokuBloc.changeValue
                                    .add([selectedX, selectedY, 6]);
                              },
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '6',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "Sofia-Pro",
                                      color: Color(0xffB7B7B7),
                                    ),
                                  ),
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: (snapshot.data[selectedY]
                                                [selectedX] ==
                                            6)
                                        ? Colors.grey
                                        : Color(0xff2D2D2D),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _sudokuBloc.changeValue
                                    .add([selectedX, selectedY, 7]);
                              },
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '7',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "Sofia-Pro",
                                      color: Color(0xffB7B7B7),
                                    ),
                                  ),
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: (snapshot.data[selectedY]
                                                [selectedX] ==
                                            7)
                                        ? Colors.grey
                                        : Color(0xff2D2D2D),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _sudokuBloc.changeValue
                                    .add([selectedX, selectedY, 8]);
                              },
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '8',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "Sofia-Pro",
                                      color: Color(0xffB7B7B7),
                                    ),
                                  ),
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: (snapshot.data[selectedY]
                                                [selectedX] ==
                                            8)
                                        ? Colors.grey
                                        : Color(0xff2D2D2D),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _sudokuBloc.changeValue
                                    .add([selectedX, selectedY, 9]);
                              },
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '9',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "Sofia-Pro",
                                      color: Color(0xffB7B7B7),
                                    ),
                                  ),
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: (snapshot.data[selectedY]
                                                [selectedX] ==
                                            9)
                                        ? Colors.grey
                                        : Color(0xff2D2D2D),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    // SizedBox(height: 25),
                    GestureDetector(
                      onTap: () {
                        _sudokuBloc.solveSudoku.add(0);
                      },
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Container(
                          alignment: Alignment.center,
                          height: 30,
                          width: 78,
                          decoration: BoxDecoration(
                            color: Color(0xffC9C9C9),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 5),
                              Text(
                                "Solve",
                                style: TextStyle(
                                  color: Color(0xff424B51),
                                ),
                              ),
                              Icon(
                                Icons.play_arrow_rounded,
                                color: Color(0xff424B51),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
