class CategoryModel {
  int? categoryId;
  String? categoryName;
  int? uId;
  CategoryModel(this.categoryId, this.categoryName, this.uId);

  CategoryModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    uId = json['u_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['u_id'] = this.uId;
    return data;
  }
}
