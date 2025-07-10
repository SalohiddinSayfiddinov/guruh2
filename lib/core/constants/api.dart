class Api {
  Api._();
  static const String baseUrl = 'https://fastapi-books-app.onrender.com';
  // static const String baseUrl = 'http://localhost:8000';

  static const String categories = '/categories';
  static const String vendorCategories = '$baseUrl/vendor-categories';
  static const String vendors = '$baseUrl/vendors';
  static const String cart = '$baseUrl/cart';
  static const String cartAdd = '$baseUrl/cart/add';
  static const String books = '$baseUrl/books';
}
