class BookModel {
  final int id;
  final String title;
  final double price;
  final String image;
  final String description;
  final String author;
  final String category;
  final double rating;
  final int reviewCount;
  final String publisher;
  final String publishedDate;
  final String language;
  final int pageCount;
  final String isbn;
  final String vendor;
  final bool specialOffer;
  final String stockStatus;
  final bool offer;
  final int discount;
  final bool topOfWeek;

  const BookModel({
    this.id = -1,
    this.title = '',
    this.price = 0.0,
    this.image = '',
    this.description = '',
    this.author = '',
    this.category = '',
    this.rating = 0.0,
    this.reviewCount = 0,
    this.publisher = '',
    this.publishedDate = '',
    this.language = '',
    this.pageCount = 0,
    this.isbn = '',
    this.vendor = '',
    this.specialOffer = false,
    this.stockStatus = 'Out of Stock',
    this.offer = false,
    this.discount = 0,
    this.topOfWeek = false,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'] ?? -1,
      title: json['title'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      image: json['image'] ?? '',
      description: json['description'] ?? '',
      author: json['author'] ?? '',
      category: json['category'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      reviewCount: json['review_count'] ?? 0,
      publisher: json['publisher'] ?? '',
      publishedDate: json['published_date'] ?? '',
      language: json['language'] ?? '',
      pageCount: json['page_count'] ?? 0,
      isbn: json['isbn'] ?? '',
      vendor: json['vendor'] ?? '',
      specialOffer: json['special_offer'] ?? false,
      stockStatus: json['stock_status'] ?? 'Out of Stock',
      offer: json['offer'] ?? false,
      discount: json['discount'] ?? 0,
      topOfWeek: json['top_of_week'] ?? false,
    );
  }
}
