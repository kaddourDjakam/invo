class ProviderModel {
  String name;
  String phoneNum;
  ProviderModel({
    this.name,
    this.phoneNum,
  });

  factory ProviderModel.fromJson(Map<String, dynamic> json) {
    return ProviderModel(
      name: json["name"],
      phoneNum: json["phoneNum"],
    );
  }
}
