import 'package:amazno_clone/common/widgets/loader.dart';
import 'package:amazno_clone/features/account/widgets/single_product.dart';
import 'package:amazno_clone/features/admin/screens/add_product_screen.dart';
import 'package:amazno_clone/features/admin/services/admin_services.dart';
import 'package:amazno_clone/models/product.dart';
import 'package:flutter/material.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final adminServices = AdminServices();
  void naviagteToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAllProducts();
  }

  List<Product>? products;

  fetchAllProducts() async {
    products = await adminServices.fetchAllProducts(context);
    setState(() {});
  }

  void deleteProduct(Product product, int index) {
    adminServices.deleteProduct(
      context: context,
      product: product,
      onSuccess: () {
        products!.removeAt(index);
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : Scaffold(
            body: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: products?.length ?? 0,
              itemBuilder: (context, index) {
                final productData = products![index];
                return Column(
                  children: [
                    SizedBox(
                      height: 140,
                      child: SingleProduct(
                        image: productData.images[0],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Text(
                            productData.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          splashRadius: 17,
                          onPressed: () {
                            deleteProduct(productData, index);
                          },
                          icon: Icon(
                            Icons.delete_outline,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                naviagteToAddProduct();
              },
              tooltip: "Add a product",
              child: const Icon(Icons.add),
            ),
          );
  }
}
