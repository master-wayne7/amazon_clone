import 'package:amazno_clone/common/widgets/loader.dart';
import 'package:amazno_clone/features/account/widgets/single_product.dart';
import 'package:amazno_clone/features/admin/services/admin_services.dart';
import 'package:amazno_clone/features/order_details/screen/order_details_screen.dart';
import 'package:amazno_clone/models/order.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final AdminServices adminServices = AdminServices();
  List<Order>? ordersList;

  void getAllOrders() async {
    ordersList = await adminServices.fetchAllOrders(context);
    setState(() {});
  }

  @override
  void initState() {
    getAllOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ordersList == null
        ? Loader()
        : GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: ordersList!.length,
            itemBuilder: (context, index) {
              Order order = ordersList![index];
              return GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, OrderDetailScreen.routeName,
                    arguments: order),
                child: SizedBox(
                  height: 140,
                  child: SingleProduct(image: order.products[0].images[0]),
                ),
              );
            },
          );
  }
}
