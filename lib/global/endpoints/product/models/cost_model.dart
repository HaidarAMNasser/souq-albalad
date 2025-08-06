
class CostModel {
  int? id;
  int? cost;
  String? fromCurrency;
  String? toCurrency;
  double? rate;
  double? costAfterChange;
  int? isMain;

  CostModel({
    this.id,
    this.cost,
    this.fromCurrency,
    this.toCurrency,
    this.rate,
    this.costAfterChange,
    this.isMain,
  });

  factory CostModel.fromJson(Map<String, dynamic> json) {
    return CostModel(
      id: json['id'],
      cost: json['cost'],
      fromCurrency: json['from_currency'],
      toCurrency: json['to_currency'],
      rate: json['rate']?.toDouble(),
      costAfterChange: json['cost_after_change']?.toDouble(),
      isMain: json['is_main'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cost'] = cost;
    data['from_currency'] = fromCurrency;
    data['to_currency'] = toCurrency;
    data['rate'] = rate;
    data['cost_after_change'] = costAfterChange;
    data['is_main'] = isMain;
    return data;
  }
}
