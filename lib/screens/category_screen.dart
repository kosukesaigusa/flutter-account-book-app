import 'package:flutter/material.dart';
import 'package:flutter_account_book_app/common/category_card.dart';
import 'package:flutter_account_book_app/models/models.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: AppBar(
              bottom: TabBar(
                tabs: tabs,
              ),
            ),
          ),
          body: ChangeNotifierProvider.value(
            value: CategoryScreenModel()
              ..fetchExpenseCategories()
              ..fetchIncomeCategories(),
            child: Consumer<CategoryScreenModel>(
              builder: (context, model, child) => TabBarView(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: ReorderableListView(
                          onReorder: (oldIndex, newIndex) {
                            debugPrint('$oldIndex, $newIndex');
                            if (oldIndex < newIndex) {
                              newIndex -= 1;
                            }
                            model.onReorderExpenseCategory(oldIndex, newIndex);
                          },
                          children: model.expenseCategories
                              .map(
                                (expenseCategory) => expenseCategoryCard(
                                    context,
                                    expenseCategory,
                                    Key(expenseCategory.expense_category_id
                                        .toString())),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Expanded(
                        child: ReorderableListView(
                          onReorder: (oldIndex, newIndex) {
                            debugPrint('$oldIndex, $newIndex');
                            if (oldIndex < newIndex) {
                              newIndex -= 1;
                            }
                            model.onReorderIncomeCategory(oldIndex, newIndex);
                          },
                          children: model.incomeCategories
                              .map(
                                (incomeCategory) => incomeCategoryCard(
                                    context,
                                    incomeCategory,
                                    Key(incomeCategory.income_category_id
                                        .toString())),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              // await insertExpenseCategories();
              // await insertIncomeCategories();
            },
            tooltip: 'カテゴリーを追加',
            child: const Icon(
              Icons.add,
              color: Colors.yellow,
            ),
          ),
        ),
      );

  final tabs = <Tab>[
    const Tab(text: '支出カテゴリー'),
    const Tab(text: '収入カテゴリー'),
  ];

  Widget expenseCategoryCard(
      BuildContext context, ExpenseCategory expenseCategory, Key key) {
    final maxWidth = MediaQuery.of(context).size.width;
    final percentageBarMaxWidth = maxWidth - percentageTextWidth - 24;
    final percentage = 0.499;
    final model = Provider.of<CategoryScreenModel>(context);
    return InkWell(
      key: key,
      onTap: () {
        print('何も起こりません');
      },
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.restaurant),
                  Flexible(
                    child: Text(
                      expenseCategory.name,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      '実績 XXX円 ',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      '/ 予算 ${expenseCategory.budget} 円',
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
      ),
    );
  }

  Widget incomeCategoryCard(
      BuildContext context, IncomeCategory incomeCategory, Key key) {
    final maxWidth = MediaQuery.of(context).size.width;
    final percentageBarMaxWidth = maxWidth - percentageTextWidth - 24;
    final percentage = 0.499;
    final model = Provider.of<CategoryScreenModel>(context);
    return InkWell(
      key: key,
      onTap: () {
        print('何も起こりません');
      },
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.restaurant),
                  Flexible(
                    child: Text(
                      incomeCategory.name,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      '実績 XXX円 ',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // Flexible(
                  //   child: Text(
                  //     '/ 予算 ${expenseCategory.budget} 円',
                  //     overflow: TextOverflow.ellipsis,
                  //   ),
                  // ),
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
      ),
    );
  }

  // Future<void> insertExpenseCategories() async {
  //   await ExpenseCategory().delete();
  //   final now = DateTime.now();
  //   final list = <Map<String, dynamic>>[
  //     <String, dynamic>{
  //       'name': '食品・栄養',
  //       'budget': 20000,
  //       'priority': 0,
  //       'icon_id': 1,
  //       'created_at': now
  //     },
  //     <String, dynamic>{
  //       'name': '外食・コンビニ',
  //       'budget': 10000,
  //       'priority': 1,
  //       'icon_id': 1,
  //       'created_at': now
  //     },
  //     <String, dynamic>{
  //       'name': '備品・消耗品',
  //       'budget': 5000,
  //       'priority': 2,
  //       'icon_id': 1,
  //       'created_at': now
  //     },
  //     <String, dynamic>{
  //       'name': '書籍・学習',
  //       'budget': 10000,
  //       'priority': 3,
  //       'icon_id': 1,
  //       'created_at': now
  //     },
  //     <String, dynamic>{
  //       'name': '洋服・美容',
  //       'budget': 10000,
  //       'priority': 4,
  //       'icon_id': 1,
  //       'created_at': now
  //     },
  //     <String, dynamic>{
  //       'name': '交通',
  //       'budget': 3000,
  //       'priority': 5,
  //       'icon_id': 1,
  //       'created_at': now
  //     },
  //     <String, dynamic>{
  //       'name': '娯楽・交際',
  //       'budget': 20000,
  //       'priority': 6,
  //       'icon_id': 1,
  //       'created_at': now
  //     },
  //     <String, dynamic>{
  //       'name': '臨時',
  //       'budget': 5000,
  //       'priority': 7,
  //       'icon_id': 1,
  //       'created_at': now
  //     },
  //   ];
  //   for (var i = 0; i < list.length; i++) {
  //     await ExpenseCategory(
  //       name: list[i]['name'] as String,
  //       budget: list[i]['budget'] as int,
  //       priority: i,
  //       icon_id: 1,
  //       created_at: now,
  //     ).save();
  //   }
  //   print('完了');
  // }

  // Future<void> insertIncomeCategories() async {
  //   await IncomeCategory().delete();
  //   final now = DateTime.now();
  //   final list = <Map<String, dynamic>>[
  //     <String, dynamic>{
  //       'name': '給料',
  //       'priority': 0,
  //       'icon_id': 1,
  //       'created_at': now
  //     },
  //     <String, dynamic>{
  //       'name': '副業',
  //       'priority': 0,
  //       'icon_id': 1,
  //       'created_at': now
  //     },
  //     <String, dynamic>{
  //       'name': '臨時収入',
  //       'priority': 0,
  //       'icon_id': 1,
  //       'created_at': now
  //     },
  //   ];
  //   for (var i = 0; i < list.length; i++) {
  //     await IncomeCategory(
  //       name: list[i]['name'] as String,
  //       priority: i,
  //       icon_id: 1,
  //       created_at: now,
  //     ).save();
  //   }
  //   print('完了');
  // }
}

class CategoryScreenModel extends ChangeNotifier {
  factory CategoryScreenModel() => _instance;
  CategoryScreenModel._internal();
  static final CategoryScreenModel _instance = CategoryScreenModel._internal();

  List<ExpenseCategory> expenseCategories = [];
  List<IncomeCategory> incomeCategories = [];

  Future<void> fetchExpenseCategories() async {
    expenseCategories =
        await ExpenseCategory().select().orderBy('priority').toList();
    notifyListeners();
  }

  Future<void> fetchIncomeCategories() async {
    incomeCategories =
        await IncomeCategory().select().orderBy('priority').toList();
    notifyListeners();
  }

  Future<void> onReorderExpenseCategory(int oldIndex, int newIndex) async {
    final target = expenseCategories[oldIndex];
    expenseCategories.removeAt(oldIndex);
    expenseCategories.insert(newIndex, target);
    notifyListeners();
    await updateExpenseCategoryOrder(expenseCategories);
  }

  Future<void> onReorderIncomeCategory(int oldIndex, int newIndex) async {
    final target = incomeCategories[oldIndex];
    incomeCategories.removeAt(oldIndex);
    incomeCategories.insert(newIndex, target);
    notifyListeners();
    await updateIncomeCategoryOrder(incomeCategories);
  }

  static Future<void> updateExpenseCategoryOrder(
      List<ExpenseCategory> expenseCategories) async {
    for (var i = 0; i < expenseCategories.length; i++) {
      await ExpenseCategory()
          .select()
          .expense_category_id
          .equals(expenseCategories[i].expense_category_id)
          .update(<String, int>{'priority': i});
    }
  }

  static Future<void> updateIncomeCategoryOrder(
      List<IncomeCategory> incomeCategories) async {
    for (var i = 0; i < incomeCategories.length; i++) {
      await IncomeCategory()
          .select()
          .income_category_id
          .equals(incomeCategories[i].income_category_id)
          .update(<String, int>{'priority': i});
    }
  }
}
