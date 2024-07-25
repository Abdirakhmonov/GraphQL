const String addProductMutation = """
mutation addProduct(
  \$title: String!, 
  \$price: Float!, 
  \$description: String!, 
) {
    addProduct(
      data: {
        title: \$title, 
        price:  \$price, 
        description: \$description, 
        categoryId: 1
        images:  ["https://placeimg.com/640/480/any"]
      }) {
      id
      title
      price
      description
      images
      category {
        name
      }
    }
}

""";

const String updateProductMutation = """
mutation updateProduct(\$id: ID!, \$changes: UpdateProductDto!) {
  updateProduct(id: \$id, changes: \$changes) {
    id
    title
    price
    description
    category {
      name
    }
  }
}
""";
const String deleteProductMutation = """
mutation DeleteProduct(\$id: ID!) {
  deleteProduct(id: \$id)
}
""";
