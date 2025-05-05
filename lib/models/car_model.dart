class Car {
  final int id;
  final String name;
  final String category;
  final double pricePerDay;
  final String imageUrl;
  final String description;
  final Map<String, dynamic> specifications;
  final bool isAvailable;
  final double rating;
  final int reviewCount;

  Car({
    required this.id,
    required this.name,
    required this.category,
    required this.pricePerDay,
    required this.imageUrl,
    required this.description,
    required this.specifications,
    required this.isAvailable,
    this.rating = 0.0,
    this.reviewCount = 0,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      pricePerDay: json['price_per_day'].toDouble(),
      imageUrl: json['image_url'],
      description: json['description'],
      specifications: json['specifications'],
      isAvailable: json['is_available'],
      rating: json['rating']?.toDouble() ?? 0.0,
      reviewCount: json['review_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'price_per_day': pricePerDay,
      'image_url': imageUrl,
      'description': description,
      'specifications': specifications,
      'is_available': isAvailable,
      'rating': rating,
      'review_count': reviewCount,
    };
  }
}
