class TransactionModel {
  TransactionModel({
    this.transactionId,
    required this.amount,
    required this.date,
    required this.category,
  });

  final int? transactionId;
  final double amount;
  final DateTime date;
  final String category;

  static TransactionModel empty() => TransactionModel(
    transactionId: null,
    amount: 0.0,
    date: DateTime.now(),
    category: '',
  );

  // Function to convert into Sqflite input
  Map<String, dynamic> toMap() {
    return {
      'transactionId': transactionId,
      'amount': amount,
      'date': date.toIso8601String(),
      'category': category,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      transactionId: map['transactionId'] as int?,
      amount: (map['amount'] as num).toDouble(),
      date: DateTime.parse(map['date'] as String),
      category: map['category'] as String,
    );
  }
}
