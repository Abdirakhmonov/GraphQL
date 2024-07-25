import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson81_dio/blocs/product/product_bloc.dart';
import 'package:lesson81_dio/data/models/product.dart';

class ManageProductScreen extends StatefulWidget {
  final bool isEdit;
  final Product? product;

  const ManageProductScreen({super.key, required this.isEdit, this.product});

  @override
  State<ManageProductScreen> createState() => _ManageProductScreenState();
}

class _ManageProductScreenState extends State<ManageProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _title = '';
  double _price = 0.0;
  String _description = '';
  List<String> _images = [];

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.product != null) {
      _title = widget.product!.title;
      _price = widget.product!.price.toDouble();
      _description = widget.product!.description;
      _images = widget.product!.images;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? 'Edit Product' : 'Add Product'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildTextFormField(
                label: 'Title',
                initialValue: _title,
                onSaved: (value) => _title = value!,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter a title'
                    : null,
              ),
              _buildTextFormField(
                label: 'Price',
                initialValue: _price.toString(),
                keyboardType: TextInputType.number,
                onSaved: (value) => _price = double.parse(value!),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter a price'
                    : null,
              ),
              _buildTextFormField(
                label: 'Description',
                initialValue: _description,
                onSaved: (value) => _description = value!,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter a description'
                    : null,
              ),
              _buildTextFormField(
                label: 'Images (comma-separated URLs)',
                initialValue: _images.join(', '),
                onSaved: (value) =>
                    _images = value!.split(',').map((e) => e.trim()).toList(),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter image URLs'
                    : null,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                Object id = widget.isEdit
                    ? widget.product!.id
                    : DateTime.now().millisecondsSinceEpoch.toString();
                final product = Product(
                  id: DateTime.now().toString(),
                  title: _title,
                  price: _price,
                  description: _description,
                  images: _images,
                );

                if (widget.isEdit) {
                  context
                      .read<ProductBloc>()
                      .add(UpdateProduct(product: product));
                } else {
                  context.read<ProductBloc>().add(AddProduct(product: product));
                }

                Navigator.of(context).pop();
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  TextFormField _buildTextFormField({
    required String label,
    required String initialValue,
    TextInputType keyboardType = TextInputType.text,
    required FormFieldSetter<String> onSaved,
    required FormFieldValidator<String> validator,
  }) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(labelText: label),
      keyboardType: keyboardType,
      onSaved: onSaved,
      validator: validator,
    );
  }
}
