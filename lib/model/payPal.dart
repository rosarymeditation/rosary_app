class PaypalModel {
  final String? payerId;
  final String? paymentId;
  final String? url;

  PaypalModel(
      {required this.payerId, required this.url, required this.paymentId});

  // PaypalModel.fromJson(Map<String, dynamic> json) {
  //   currency = json['currency'];
  //   code = json['code'];
  // }
  factory PaypalModel.fromJson(Map<String, dynamic> json) {
    return PaypalModel(
      payerId: json['payerId'],
      url: json['url'],
      paymentId: json['paymentId'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['payerId'] = payerId;
    data['url'] = url;
    data['paymentId'] = paymentId;

    return data;
  }
}
