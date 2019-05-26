class ApplicationDao {
  final String productId;
  final String title;
  final String description;
  final List<Map<String, String>> tasks;

  ApplicationDao({this.productId, this.title, this.description, this.tasks});

  factory ApplicationDao.fromJson(Map<String, dynamic> json) {
    return ApplicationDao(
      productId: json['product_id'],
      title: json['title'],
      description: json['description'],
      tasks: json['tasks'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map['product_id'] = productId;
    map["title"] = title;
    map["description"] = description;
    map["tasks"] = tasks;

    return map;
  }
}
