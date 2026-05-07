class BudgetCycleModel {
  BudgetCycleModel({
    this.cycleId,
    required this.totalAllowance,
    required this.startDate,
    required this.endDate,
  });

  final int? cycleId;
  final double totalAllowance;
  final DateTime startDate;
  final DateTime endDate;

  static BudgetCycleModel empty() => BudgetCycleModel(
    cycleId: null,
    totalAllowance: 0.0,
    startDate: DateTime.now(),
    endDate: DateTime.now(),
  );

  // Function to convert into Sqflite input
  Map<String, dynamic> toMap() {
    return {
      'cycleId': cycleId,
      'totalAllowance': totalAllowance,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    };
  }

  factory BudgetCycleModel.fromMap(Map<String, dynamic> map) {
    return BudgetCycleModel(
      cycleId: map['cycleId'] as int?,
      totalAllowance: (map['totalAllowance'] as num).toDouble(),
      startDate: DateTime.parse(map['startDate'] as String),
      endDate: DateTime.parse(map['endDate'] as String),
    );
  }

  int get totalDays => endDate.difference(startDate).inDays + 1;

  double get dailyLimit {
    if (totalDays <= 0) return totalAllowance;
    return totalAllowance / totalDays;
  }

  double get weeklyLimit {
    if (totalDays <= 7) return totalAllowance;
    return dailyLimit * 7;
  }

  double get monthlyLimit {
    if (totalDays <= 30) return totalAllowance;
    return dailyLimit * 30;
  }
}
