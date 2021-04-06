import 'package:flutter/material.dart';
import 'package:flutter_account_book_app/models/models.dart';
import 'package:provider/provider.dart';

class FixedFeeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: ChangeNotifierProvider.value(
          value: FixedFeeScreenModel()..fetchFixedFees(),
          child: Consumer<FixedFeeScreenModel>(
            builder: (context, model, child) => Column(
              children: [
                Row(
                  children: [
                    const Text('固定費合計金額：'),
                    Text('${model.totalPrice()} 円'),
                  ],
                ),
                Expanded(
                  child: ReorderableListView(
                    onReorder: (oldIndex, newIndex) {
                      debugPrint('$oldIndex, $newIndex');
                      if (oldIndex < newIndex) {
                        newIndex -= 1;
                      }
                      model.onReorder(oldIndex, newIndex);
                    },
                    children: model.fixedFees
                        .map(
                          (fixedFee) => fixedFeeCard(model, fixedFee,
                              Key(fixedFee.fixed_fee_id.toString())),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: 'fixedfee-screen-fab',
          onPressed: () async {
            // await insertFixedFees();
          },
          tooltip: '固定費を追加',
          child: const Icon(
            Icons.add,
            color: Colors.yellow,
          ),
        ),
      );

  Widget fixedFeeCard(FixedFeeScreenModel model, FixedFee fixedFee, Key key) =>
      InkWell(
        key: key,
        onTap: () async {
          debugPrint('タップしたのは ${fixedFee.name}');
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      fixedFee.name,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      '月額 ${calcMonthlyFee(fixedFee)} 円'
                      ' (priority: ${fixedFee.priority})',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              fixedFee.note.isNotEmpty
                  ? Row(
                      children: [
                        Flexible(
                          child: Text(
                            '${fixedFee.note}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      );

  int calcMonthlyFee(FixedFee fixedFee) {
    return (fixedFee.price / fixedFee.payment_cycle_id).ceil();
  }

  Future<void> insertFixedFees() async {
    final now = DateTime.now();
    final fixedFees = <Map<String, dynamic>>[
      <String, dynamic>{
        'name': '家賃',
        'price': 90330,
        'payment_cycle_id': 1,
        'note': '',
        'priority': 1,
        'created_at': now,
      },
      <String, dynamic>{
        'name': '電気',
        'price': 7000,
        'payment_cycle_id': 1,
        'note': '',
        'priority': 2,
        'created_at': now,
      },
      <String, dynamic>{
        'name': '水道',
        'price': 2000,
        'payment_cycle_id': 1,
        'note': '',
        'priority': 3,
        'created_at': now,
      },
      <String, dynamic>{
        'name': 'LINE モバイル',
        'price': 2000,
        'payment_cycle_id': 1,
        'note': '',
        'priority': 4,
        'created_at': now,
      },
      <String, dynamic>{
        'name': 'en ひかり',
        'price': 3828,
        'payment_cycle_id': 1,
        'note': '',
        'priority': 5,
        'created_at': now,
      },
      <String, dynamic>{
        'name': 'Flutter 大学',
        'price': 2200,
        'payment_cycle_id': 1,
        'note': '',
        'priority': 6,
        'created_at': now,
      },
      <String, dynamic>{
        'name': 'YouTube Premium',
        'price': 1180,
        'payment_cycle_id': 1,
        'note': '',
        'priority': 7,
        'created_at': now,
      },
      <String, dynamic>{
        'name': 'Amazon Gold カード',
        'price': 4400,
        'payment_cycle_id': 12,
        'note': '加入日：2019年6月5日。年会費の支払いは毎年7月の請求。'
            '元の11,000円から、マイペイリスボで5,500円、'
            'Web 明細で1,100円の割引により、合計4,400円。',
        'priority': 8,
        'created_at': now,
      },
      <String, dynamic>{
        'name': 'Apple Developer Program',
        'price': 12980,
        'payment_cycle_id': 12,
        'note': '加入日：2020年9月5日。11,800円+税 = 12,980円',
        'priority': 9,
        'created_at': now,
      },
      <String, dynamic>{
        'name': '1Password',
        'price': 4500,
        'payment_cycle_id': 12,
        'note': '支払日：毎年5月24日。'
            '2.99ドル/月（年払い）× 12ヶ月 × 1.10（消費税） = 39.47ドル ≒ 4500円',
        'priority': 10,
        'created_at': now,
      },
      <String, dynamic>{
        'name': 'Google Domains',
        'price': 1540,
        'payment_cycle_id': 12,
        'note': '毎年1月30日に更新。1,400円+税 = 1,540円',
        'priority': 11,
        'created_at': now,
      },
    ];

    for (var i = 0; i < fixedFees.length; i++) {
      final result = await FixedFee(
        name: fixedFees[i]['name'].toString(),
        price: fixedFees[i]['price'] as int,
        payment_cycle_id: fixedFees[i]['payment_cycle_id'] as int,
        note: fixedFees[i]['note'].toString(),
        priority: fixedFees[i]['priority'] as int,
        created_at: fixedFees[i]['created_at'] as DateTime,
      ).save();
      debugPrint('result: $result');
    }
  }
}

class FixedFeeScreenModel extends ChangeNotifier {
  factory FixedFeeScreenModel() => _instance;
  FixedFeeScreenModel._internal();
  static final FixedFeeScreenModel _instance = FixedFeeScreenModel._internal();

  List<FixedFee> fixedFees = [];

  void runNotifyListeners() {
    notifyListeners();
  }

  Future<void> fetchFixedFees() async {
    fixedFees = await FixedFee().select().orderBy('priority').toList();
    notifyListeners();
  }

  Future<void> onReorder(int oldIndex, int newIndex) async {
    final target = fixedFees[oldIndex];
    fixedFees.removeAt(oldIndex);
    fixedFees.insert(newIndex, target);
    notifyListeners();
    await updateFixedFeeOrder(fixedFees);
  }

  int totalPrice() {
    var price = 0;
    for (final fixedFee in fixedFees) {
      price += (fixedFee.price / fixedFee.payment_cycle_id).ceil();
    }
    return price;
  }

  static Future<void> updateFixedFeeOrder(List<FixedFee> fixedFees) async {
    for (var i = 0; i < fixedFees.length; i++) {
      await FixedFee()
          .select()
          .fixed_fee_id
          .equals(fixedFees[i].fixed_fee_id)
          .update(<String, int>{'priority': i});
    }
  }
}
