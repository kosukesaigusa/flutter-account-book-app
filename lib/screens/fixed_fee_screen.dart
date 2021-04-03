import 'package:flutter/material.dart';
import 'package:flutter_account_book_app/models/models.dart';
import 'package:provider/provider.dart';

class FixedFeeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        child: ChangeNotifierProvider.value(
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
      );

  Widget fixedFeeCard(FixedFeeScreenModel model, FixedFee fixedFee, Key key) =>
      InkWell(
        key: key,
        onTap: () {
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
                      '月額 ${calcMonthlyFee(fixedFee)} 円',
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
