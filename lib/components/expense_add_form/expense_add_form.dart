import 'package:flutter/material.dart';
import 'package:flutter_account_book_app/common/theme.dart';

/// フォーム間の境界線
const dividerWidget = Divider(
  color: greyColor,
  height: 5,
  thickness: 1,
);

/// フォームの外側の余白
const double paddingWidth = 8;

/// ラベル部分の長さ
const double labelWidth = 45;

/// 進む・戻るボタンの横幅
const double iconWidth = 24;

/// 日付ラベルと戻るボタンの間の余白
const double marginWidth = 20;

/// メモ・値段ラベルとテキストフォームの間の余白
const double marginWidth2 = iconWidth + marginWidth;

/// メモや値段の入力フォームの高さ
double inputFormHeight = 28;

/// メモや値段の入力フォームの横幅
double inputFormWidth(BuildContext context) {
  final maxWidth = MediaQuery.of(context).size.width;
  return maxWidth - paddingWidth * 2 - labelWidth - marginWidth - iconWidth * 2;
}

const double categoryCardWidth = 120;
