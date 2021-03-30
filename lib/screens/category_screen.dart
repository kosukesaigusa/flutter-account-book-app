import 'package:flutter/material.dart';
import 'package:flutter_account_book_app/components/category/category_card.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        child: ListView.builder(
          itemCount: cardList.length,
          itemBuilder: (context, index) {
            return cardList[index];
          },
        ),
      );

  final cardList = <Widget>[
    CategoryCardWidget(),
    CategoryCardWidget(),
    CategoryCardWidget(),
    CategoryCardWidget(),
    CategoryCardWidget(),
  ];
}
