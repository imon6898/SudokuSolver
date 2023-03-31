import 'dart:async';

class SudokuBloc {
  List<List<int>> _grid = [
    [5, 3, 0, 0, 7, 0, 0, 1, 0],
    [6, 0, 0, 1, 9, 5, 0, 0, 8],
    [0, 9, 8, 0, 0, 0, 5, 6, 0],
    [8, 0, 0, 7, 6, 0, 0, 2, 3],
    [4, 0, 0, 8, 0, 3, 0, 0, 1],
    [7, 0, 0, 0, 2, 0, 0, 0, 6],
    [9, 6, 0, 5, 0, 0, 2, 8, 0],
    [0, 0, 0, 4, 1, 9, 0, 0, 5],
    [0, 0, 5, 0, 8, 0, 0, 7, 9]
  ];
  bool _got = false;
  final _sudokuStreamController = StreamController<List<List<int>>>();
  final _changeValueStreamController = StreamController<List<int>>();
  final _solveStreamController = StreamController<int>();
  final _changeGridController = StreamController<List<List<int>>>();

  Stream<List<List<int>>> get sudokuGridStream =>
      _sudokuStreamController.stream;
  StreamSink<List<List<int>>> get sudokuGridSink =>
      _sudokuStreamController.sink;

  StreamSink<List<int>> get changeValue => _changeValueStreamController.sink;
  StreamSink<int> get solveSudoku => _solveStreamController.sink;
  StreamSink<List<List<int>>> get changeGridSink => _changeGridController.sink;
  SudokuBloc() {
    _sudokuStreamController.add(_grid);
    _changeValueStreamController.stream.listen(_changeValueFunc);
    _solveStreamController.stream.listen(_solve);
    _changeGridController.stream.listen(_changeGridFunc);
  }
  _changeValueFunc(List<int> a) {
    _got = false;
    _grid[a[1]][a[0]] = a[2];
    sudokuGridSink.add(_grid);
  }

  _changeGridFunc(List<List<int>> newGrid) {
    _grid = newGrid;
    _got = false;
    sudokuGridSink.add(_grid);
  }

  void dispose() {
    _sudokuStreamController.close();
    _changeValueStreamController.close();
    _solveStreamController.close();
    _changeGridController.close();
  }

  bool _possible(int y, int x, int n) {
    for (int i = 0; i < 9; i++) {
      if (_grid[y][i] == n) {
        return false;
      }
    }
    for (int i = 0; i < 9; i++) {
      if (_grid[i][x] == n) {
        return false;
      }
    }
    int x0 = (x ~/ 3) * 3;
    int y0 = (y ~/ 3) * 3;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (_grid[y0 + i][x0 + j] == n) {
          return false;
        }
      }
    }
    return true;
  }

  _solve(int kkk) {
    for (int y = 0; y < 9; y++) {
      for (int x = 0; x < 9; x++) {
        if (_grid[y][x] == 0) {
          for (int n = 1; n < 10; n++) {
            if (_possible(y, x, n)) {
              _grid[y][x] = n;
              _solve(kkk);
              if (!_got) {
                _grid[y][x] = 0;
              }
            }
          }
          return;
        }
      }
    }
    _got = true;
    sudokuGridSink.add(_grid);
  }
}
