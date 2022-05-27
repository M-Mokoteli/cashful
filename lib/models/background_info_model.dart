import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class BackgroundInformation {
  final String? id;
  late String? creditScoreValue;
  late String? employmentStatus;
  late bool? isCreditScorePresent;
  late bool? isSmallBusinessOwner;
  late String? businessOffering;
  late String? lengthOfOperation;
  late String? sourceOfFinancing;
  late String? businessExpenceMonthly;
  late String? businessrevenueMonthly;
  late String? investmentToDate;
  late String? savingMonthly;
  late String? stockvelContribution;
  late bool? isPartOfStockvel;
  late String? highestLevelOfEducation;
  late String? sourceOfIncome;
  late String? monthlyIncome;
  late String? monthlyExpense;
  BackgroundInformation({
    this.id,
    this.creditScoreValue,
    this.employmentStatus,
    this.isCreditScorePresent = false,
    this.isSmallBusinessOwner = false,
    this.businessOffering,
    this.lengthOfOperation,
    this.sourceOfFinancing,
    this.businessExpenceMonthly,
    this.businessrevenueMonthly,
    this.investmentToDate,
    this.savingMonthly,
    this.stockvelContribution,
    this.isPartOfStockvel = false,
    this.highestLevelOfEducation,
    this.sourceOfIncome,
    this.monthlyIncome,
    this.monthlyExpense,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'creditScoreValue': creditScoreValue,
      'employmentStatus': employmentStatus,
      'isCreditScorePresent': isCreditScorePresent,
      'isSmallBusinessOwner': isSmallBusinessOwner,
      'businessOffering': businessOffering,
      'lengthOfOperation': lengthOfOperation,
      'sourceOfFinancing': sourceOfFinancing,
      'businessExpenceMonthly': businessExpenceMonthly,
      'businessrevenueMonthly': businessrevenueMonthly,
      'investmentToDate': investmentToDate,
      'savingMonthly': savingMonthly,
      'stockvelContribution': stockvelContribution,
      'isPartOfStockvel': isPartOfStockvel,
      'highestLevelOfEducation': highestLevelOfEducation,
      'sourceOfIncome': sourceOfIncome,
      'monthlyIncome': monthlyIncome,
      'monthlyExpense': monthlyExpense,
    };
  }

  factory BackgroundInformation.fromMap(Map<String, dynamic> map) {
    return BackgroundInformation(
      id: map['id'],
      creditScoreValue: map['creditScoreValue'],
      employmentStatus: map['employmentStatus'],
      isCreditScorePresent: map['isCreditScorePresent'],
      isSmallBusinessOwner: map['isSmallBusinessOwner'],
      businessOffering: map['businessOffering'],
      lengthOfOperation: map['lengthOfOperation'],
      sourceOfFinancing: map['sourceOfFinancing'],
      businessExpenceMonthly: map['businessExpenceMonthly'],
      businessrevenueMonthly: map['businessrevenueMonthly'],
      investmentToDate: map['investmentToDate'],
      savingMonthly: map['savingMonthly'],
      stockvelContribution: map['stockvelContribution'],
      isPartOfStockvel: map['isPartOfStockvel'],
      highestLevelOfEducation: map['highestLevelOfEducation'],
      sourceOfIncome: map['sourceOfIncome'],
      monthlyIncome: map['monthlyIncome'],
      monthlyExpense: map['monthlyExpense'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BackgroundInformation.fromJson(String source) =>
      BackgroundInformation.fromMap(json.decode(source));

  factory BackgroundInformation.fromFirebase(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    data['id'] = snapshot.id;
    return BackgroundInformation.fromMap(data);
  }

  factory BackgroundInformation.mock() {
    return BackgroundInformation(
        businessExpenceMonthly: "100",
        businessOffering: "test",
        businessrevenueMonthly: "1000",
        creditScoreValue: "",
        employmentStatus: null,
        highestLevelOfEducation: "Postgraduate",
        id: null,
        investmentToDate: "R7500 - R9999",
        isCreditScorePresent: false,
        isPartOfStockvel: false,
        isSmallBusinessOwner: true,
        lengthOfOperation: "tesy",
        monthlyExpense: null,
        monthlyIncome: null,
        savingMonthly: "R250 - R499",
        sourceOfFinancing: "Personal savings",
        sourceOfIncome: null,
        stockvelContribution: "");
  }
}
