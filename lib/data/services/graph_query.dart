const String fetchProductsQuery = """
  query { 
    products {
      id
      title
      price
      description
      images
    }
  }
""";

// (limit:6, offset:0)