class Product {
  int id;
  String title;
  String data;
  String image;
  int marcketPrice;
  int sellingPrice;
  String description;
  Category category;
  bool cat1;
  bool cat2;
  bool cat3;

  Product(
      {this.id,
      this.title,
      this.data,
      this.image,
      this.marcketPrice,
      this.sellingPrice,
      this.description,
      this.category,
      this.cat1,
      this.cat2,
      this.cat3});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    data = json['data'];
    image = json['image'];
    marcketPrice = json['marcket_price'];
    sellingPrice = json['selling_price'];
    description = json['description'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    cat1 = json['cat1'];
    cat2 = json['cat2'];
    cat3 = json['cat3'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['data'] = this.data;
    data['image'] = this.image;
    data['marcket_price'] = this.marcketPrice;
    data['selling_price'] = this.sellingPrice;
    data['description'] = this.description;
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    data['cat1'] = this.cat1;
    data['cat2'] = this.cat2;
    data['cat3'] = this.cat3;
    return data;
  }
}

class Category {
  int id;
  String title;
  String date;

  Category({this.id, this.title, this.date});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['date'] = this.date;
    return data;
  }
}
