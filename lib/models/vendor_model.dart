class Vendor {
  Vendor({
    required this.vendorId,
    required this.vendorName,
    required this.vendorLongitute,
    required this.vendorLatitude,
    required this.vendorTotalStockValue,
    required this.vendorImageUrl,
  });

  String vendorId;
  String vendorName;
  double vendorLongitute;
  double vendorLatitude;
  int vendorTotalStockValue;
  String vendorImageUrl;

  factory Vendor.fromJson(Map<String, dynamic> json, String docId) {
    if (json.isEmpty || docId.isEmpty) {
      throw "Vendor data: json or docId is null";
    }
    return Vendor(
      vendorId: docId,
      vendorName: json["vendor_name"],
      vendorLongitute: json["vendor_longitute"].toDouble(),
      vendorLatitude: json["vendor_latitude"].toDouble(),
      vendorTotalStockValue: json["vendor_total_stock_value"],
      vendorImageUrl: json["vendor_image_url"],
    );
  }

  Map<String, dynamic> toJson() => {
        //"vendor_id": vendorId,
        "vendor_name": vendorName,
        "vendor_longitute": vendorLongitute,
        "vendor_latitude": vendorLatitude,
        "vendor_total_stock_value": vendorTotalStockValue,
        "vendor_image_url": vendorImageUrl,
      };
}
