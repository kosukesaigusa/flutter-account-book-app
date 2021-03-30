import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sqfentity/sqfentity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';
part 'models.g.dart';

@SqfEntityBuilder(dbModel)
const dbModel = SqfEntityModel(
  modelName: 'DbModel',
  databaseName: 'account_book_app.db',
  databaseTables: [
    expense,
    income,
    expenseCategory,
    incomeCategory,
    fixedFee,
    icon,
    paymentCycle,
  ],
  bundledDatabasePath: null,
);

const expense = SqfEntityTable(
  modelName: 'Expense',
  tableName: 'expense',
  primaryKeyName: 'expense_id',
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  useSoftDeleting: true,
  fields: [
    SqfEntityField('note', DbType.text),
    SqfEntityFieldRelationship(
      parentTable: expenseCategory,
      fieldName: 'expense_category_id',
      relationType: RelationType.ONE_TO_MANY,
    ),
    SqfEntityField('price', DbType.integer),
    SqfEntityField('satisfaction', DbType.integer,
        defaultValue: 3, minValue: 1, maxValue: 5),
    SqfEntityField('year', DbType.integer),
    SqfEntityField('month', DbType.integer),
    SqfEntityField('date', DbType.integer),
    SqfEntityField('created_at', DbType.datetime),
  ],
);

const income = SqfEntityTable(
  modelName: 'Income',
  tableName: 'income',
  primaryKeyName: 'income_id',
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  useSoftDeleting: true,
  fields: [
    SqfEntityField('note', DbType.text),
    SqfEntityFieldRelationship(
      parentTable: incomeCategory,
      fieldName: 'income_category_id',
      relationType: RelationType.ONE_TO_MANY,
    ),
    SqfEntityField('price', DbType.integer),
    SqfEntityField('year', DbType.integer),
    SqfEntityField('month', DbType.integer),
    SqfEntityField('date', DbType.integer),
    SqfEntityField('created_at', DbType.datetime),
  ],
);

const expenseCategory = SqfEntityTable(
  modelName: 'ExpenseCategory',
  tableName: 'expensecategory',
  primaryKeyName: 'expense_category_id',
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  useSoftDeleting: true,
  fields: [
    SqfEntityField('name', DbType.text),
    SqfEntityField('budget', DbType.integer),
    SqfEntityField('priority', DbType.integer),
    SqfEntityFieldRelationship(
      parentTable: icon,
      fieldName: 'icon_id',
      relationType: RelationType.ONE_TO_MANY,
    ),
    SqfEntityField('created_at', DbType.datetime),
  ],
);

const incomeCategory = SqfEntityTable(
  modelName: 'IncomeCategory',
  tableName: 'incomecategory',
  primaryKeyName: 'income_category_id',
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  useSoftDeleting: true,
  fields: [
    SqfEntityField('name', DbType.text),
    SqfEntityField('priority', DbType.integer),
    SqfEntityFieldRelationship(
      parentTable: icon,
      fieldName: 'icon_id',
      relationType: RelationType.ONE_TO_MANY,
    ),
    SqfEntityField('created_at', DbType.datetime),
  ],
);

const fixedFee = SqfEntityTable(
  modelName: 'FixedFee',
  tableName: 'fixedfee',
  primaryKeyName: 'fixed_fee_id',
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  useSoftDeleting: true,
  fields: [
    SqfEntityField('name', DbType.text),
    SqfEntityField('price', DbType.integer),
    SqfEntityFieldRelationship(
      parentTable: paymentCycle,
      fieldName: 'payment_cycle_id',
      relationType: RelationType.ONE_TO_MANY,
    ),
    SqfEntityField('note', DbType.text),
    SqfEntityField('priority', DbType.integer),
    SqfEntityField('created_at', DbType.datetime),
  ],
);

const icon = SqfEntityTable(
  modelName: 'AppIcon',
  tableName: 'icon',
  primaryKeyName: 'icon_id',
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  useSoftDeleting: false,
  fields: [
    SqfEntityField('name', DbType.text),
    SqfEntityField('priority', DbType.integer),
  ],
);

const paymentCycle = SqfEntityTable(
  modelName: 'PaymentCycle',
  tableName: 'paymentcycle',
  primaryKeyName: 'payment_cycle_id',
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  useSoftDeleting: false,
  fields: [
    SqfEntityField('month', DbType.integer),
    SqfEntityField('priority', DbType.integer),
  ],
);
