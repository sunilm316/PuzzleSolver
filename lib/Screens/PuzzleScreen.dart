import 'dart:math';

import 'package:flutter/material.dart';
import 'package:puzzlesolver/Models/PuzzleModel.dart';

class PuzzleScreen extends StatefulWidget {
  @override
  _PuzzleScreenState createState() => _PuzzleScreenState();
}

class _PuzzleScreenState extends State<PuzzleScreen> {
  int row = 5;
  int col = 5;
  List<List<PuzzleModel>> twoDList;
  List<SelectedItem> selectedList = List();
  List<Color> colors = List();
  int treeCount = 0;

  @override
  void initState() {
    twoDList = List.generate(row,
        (i) => List<PuzzleModel>.generate(col, (int index) => PuzzleModel()),
        growable: false);
    colors = [
      Colors.red,
      Colors.blue[900],
      Colors.green,
      Colors.pink,
      Colors.grey
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: renderBody(),
    );
  }

  renderBody() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (var _color in colors)
                InkWell(
                  onTap: () {
                    for (var _selectedItem in selectedList) {
                      twoDList[_selectedItem.rowIndex][_selectedItem.colIndex]
                          .color = _color;
                    }
                    selectedList.clear();
                    setState(() {});
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(color: _color),
                  ),
                )
            ],
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: row,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, rowIndex) {
                return Container(
                  height: 80,
                  child: ListView.builder(
                      itemCount: col,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, colIndex) {
                        return InkWell(
                          onTap: () {
                            SelectedItem _selectedItem = SelectedItem();
                            _selectedItem.rowIndex = rowIndex;
                            _selectedItem.colIndex = colIndex;
                            selectedList.add(_selectedItem);
                            setState(() {});
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width / 5,
                              height: MediaQuery.of(context).size.width / 5,
                              decoration: BoxDecoration(
                                  color: checkItemSelected(rowIndex, colIndex)
                                      ? Colors.blue
                                      : twoDList[rowIndex][colIndex] != null &&
                                              twoDList[rowIndex][colIndex]
                                                      .color !=
                                                  null
                                          ? twoDList[rowIndex][colIndex].color
                                          : Colors.white,
                                  border: Border.all(color: Colors.grey)),
                              child: Center(
                                  child: Text(rowIndex.toString() +
                                      "," +
                                      colIndex.toString() +
                                      "\n" +
                                      twoDList[rowIndex][colIndex]
                                          .item
                                          .toString()))),
                        );
                      }),
                );
              }),
          RaisedButton(onPressed: generateInit, child: Text("Generate"))
        ],
      ),
    );
  }

  generateInit() {
    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 5; j++) {
        print(treeCount);
        if (treeCount != 5) {
          clearAll();
          treeCount = 0;
          generate(i, j);
        } else {
          setState(() {});
          break;
        }
      }
      if (treeCount == 5) {
        break;
      }
    }
    setState(() {});
  }

  generate(int _rowIndexIni, int _colIndexIni) {
    for (int _rowIndex = _rowIndexIni; _rowIndex < row; _rowIndex++) {
      for (int _colIndex = _colIndexIni; _colIndex < col; _colIndex++) {
        if (twoDList[_rowIndex][_colIndex].item == null) {
          addTree(_rowIndex, _colIndex);
        }
      }
    }
    setState(() {});
  }

  clearAll() {
    for (int _rowIndex = 0; _rowIndex < row; _rowIndex++) {
      for (int _colIndex = 0; _colIndex < col; _colIndex++) {
        twoDList[_rowIndex][_colIndex].item = null;
      }
    }
  }

  addTree(int _rowIndexP, int _colIndexP) {
    for (int _rowIndex = 0; _rowIndex < row; _rowIndex++) {
      for (int _colIndex = 0; _colIndex < col; _colIndex++) {
        if (_rowIndexP == _rowIndex &&
            _colIndexP == _colIndex &&
            twoDList[_rowIndex][_colIndex].item == null &&
            !isTreeAddedToPark(twoDList[_rowIndex][_colIndex].color)) {
          twoDList[_rowIndex][_colIndex].item = 'Tree';
          addDotToPark(twoDList[_rowIndex][_colIndex].color);
          addDot(_rowIndex, _colIndex);
          treeCount++;
        }
      }
    }
  }

  addDotToPark(Color _color) {
    for (int _rowIndex = 0; _rowIndex < row; _rowIndex++) {
      for (int _colIndex = 0; _colIndex < col; _colIndex++) {
        if (twoDList[_rowIndex][_colIndex].color == _color &&
            twoDList[_rowIndex][_colIndex].item == null) {
          twoDList[_rowIndex][_colIndex].item = 'Dot';
        }
      }
    }
  }

  bool isTreeAddedToPark(Color _color) {
    for (int _rowIndex = 0; _rowIndex < row; _rowIndex++) {
      for (int _colIndex = 0; _colIndex < col; _colIndex++) {
        if (twoDList[_rowIndex][_colIndex].color == _color &&
            twoDList[_rowIndex][_colIndex].item == 'Tree') {
          return true;
        }
      }
    }
    return false;
  }

  addDot(int _rowIndexP, int _colIndexP) {
    for (int _rowIndex = 0; _rowIndex < row; _rowIndex++) {
      for (int _colIndex = 0; _colIndex < col; _colIndex++) {
        if (twoDList[_rowIndex][_colIndex].item == null &&
            (_rowIndexP == _rowIndex || _colIndexP == _colIndex))
          twoDList[_rowIndex][_colIndex].item = 'Dot';

        if (_rowIndexP - 1 >= 0)
          twoDList[_rowIndexP - 1][_colIndexP].item = 'Dot';

        if (_colIndexP - 1 >= 0)
          twoDList[_rowIndexP][_colIndexP - 1].item = 'Dot';

        if (_rowIndexP - 1 >= 0 && _colIndexP - 1 >= 0)
          twoDList[_rowIndexP - 1][_colIndexP - 1].item = 'Dot';

        if (_rowIndexP + 1 < row)
          twoDList[_rowIndexP + 1][_colIndexP].item = 'Dot';

        if (_colIndexP + 1 < col)
          twoDList[_rowIndexP][_colIndexP + 1].item = 'Dot';

        if (_rowIndexP + 1 < row && _colIndexP + 1 < col)
          twoDList[_rowIndexP + 1][_colIndexP + 1].item = 'Dot';

        if (_rowIndexP + 1 < row && _colIndexP - 1 >= 0)
          twoDList[_rowIndexP + 1][_colIndexP - 1].item = 'Dot';

        if (_rowIndexP - 1 >= 0 && _colIndexP + 1 < col)
          twoDList[_rowIndexP - 1][_colIndexP + 1].item = 'Dot';
      }
    }
  }

  bool checkItemSelected(rowIndex, colIndex) {
    for (var _selectedItem in selectedList) {
      if (_selectedItem.rowIndex == rowIndex &&
          _selectedItem.colIndex == colIndex) return true;
    }
    return false;
  }
}
