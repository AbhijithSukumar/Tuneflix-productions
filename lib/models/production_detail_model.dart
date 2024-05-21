class ProductionDetailModel {
  final String companyName;
  final String regID;
  final String address;
  final String website;
  final String productionID;

  ProductionDetailModel(
      {required this.companyName,
      required this.regID,
      required this.address,
      required this.website,
      required this.productionID});

  Map<String, dynamic> toMap() {
    return {
      "companyName": companyName,
      "regID": regID,
      "address": address,
      "website": website,
      "productionID":productionID
    };
  }
}
