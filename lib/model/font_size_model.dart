class FontSizeModel {
  String? headerOne;
  String? headerTwo;
  String? headerThree;
  String? paragraph;

  FontSizeModel({
    this.headerOne,
    this.headerTwo,
    this.headerThree,
    this.paragraph,
  });

  FontSizeModel.fromJson(Map<String, dynamic> json) {
    headerOne = json['headerOne'];
    headerTwo = json['headerTwo'];
    headerThree = json['headerThree'];
    paragraph = json['paragraph'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['headerOne'] = this.headerOne;
    data['headerTwo'] = this.headerTwo;
    data['headerThree'] = this.headerThree;
    data['paragraph'] = this.paragraph;

    return data;
  }
}
