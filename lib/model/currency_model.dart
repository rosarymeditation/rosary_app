class Currency {
  late List<CurrencyModel> _currencies;
  List<CurrencyModel> get currencies => _currencies;
  Currency({
    required currencies,
  }) {
    this._currencies = currencies;
  }

  Currency.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _currencies = <CurrencyModel>[];
      json['data'].forEach((v) {
        _currencies.add(new CurrencyModel.fromJson(v));
      });
    }
  }
}

class CurrencyModel {
  final String? country;
  final String? code;

  CurrencyModel({
    required this.country,
    required this.code,
  });

  // CurrencyModel.fromJson(Map<String, dynamic> json) {
  //   country = json['country'];
  //   code = json['code'];
  // }
  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      country: json['country'],
      code: json['code'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['country'] = country;
    data['code'] = code;

    return data;
  }
}
