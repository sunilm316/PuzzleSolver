import 'package:flutter/material.dart';

class PuzzleModel {
  String item;
  Color color;

  PuzzleModel({this.color, this.item});
}

class SelectedItem {
  int rowIndex;
  int colIndex;

  SelectedItem({this.colIndex, this.rowIndex});
}
