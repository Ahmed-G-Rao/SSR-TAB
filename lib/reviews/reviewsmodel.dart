class ReviewsModel {
  int? status;
  List<Data>? data;
  String? message;

  ReviewsModel({this.status, this.data, this.message});

  ReviewsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  int? reviewId;
  String? user_name;
  String? review;
  int? stars;
  String? createdAt;
  void updatedAt;

  Data(
      {this.reviewId,
      this.user_name,
      this.review,
      this.stars,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    reviewId = json['review_id'];
    user_name = json['user_name'];
    review = json['review'];
    stars = json['stars'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['review_id'] = reviewId;
    data['user_name'] = user_name;
    data['review'] = review;
    data['stars'] = stars;
    data['created_at'] = createdAt;

    return data;
  }
}
