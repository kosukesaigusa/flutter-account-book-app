import 'package:flutter/material.dart';
import 'package:flutter_account_book_app/common/calendar_card.dart';

class CategoryCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    final percentageBarMaxWidth = maxWidth - percentageTextWidth - 16;
    final percentage = 0.499;
    return InkWell(
      onTap: () {
        print('何も起こりません');
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.restaurant),
                Flexible(
                  child: Text(
                    '食品・栄養',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: Text(
                    '実績 4,990円 ',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Flexible(
                  child: Text(
                    '/ 予算 10,000 円',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Stack(
                  children: [
                    Container(
                      height: percentageBarHight,
                      width: percentageBarMaxWidth,
                      color: Colors.grey,
                    ),
                    Container(
                      height: percentageBarHight,
                      width: percentage > 1
                          ? percentageBarMaxWidth
                          : percentageBarMaxWidth * percentage,
                      color: percentage > 1 ? Colors.red : Colors.orange,
                    ),
                  ],
                ),
                const SizedBox(
                  width: percentageTextWidth,
                  child: Text(
                    '49.9 %',
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
