import 'package:amazno_clone/common/widgets/common_appbar.dart';
import 'package:amazno_clone/common/widgets/custom_button.dart';
import 'package:amazno_clone/constants/global_variables.dart';
import 'package:amazno_clone/features/admin/services/admin_services.dart';
import 'package:amazno_clone/models/order.dart';
import 'package:amazno_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderDetailScreen extends StatefulWidget {
  final Order order;
  static const routeName = '/order-details';
  const OrderDetailScreen({super.key, required this.order});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  int currentStep = 0;
  final AdminServices adminServices = AdminServices();

  void updateStatus() {
    adminServices.updateStatus(
        context: context,
        order: widget.order,
        status: currentStep + 1,
        onSuccess: () {
          currentStep += 1;
          setState(() {});
        });
  }

  @override
  void initState() {
    super.initState();
    currentStep = widget.order.status;
  }

  @override
  Widget build(BuildContext context) {
    String shippedDate = "";
    String deliveryDate = "";
    String arrivalDate = "";
    final user = Provider.of<UserProvider>(context).user;
    DateTime orderDate = DateTime.fromMillisecondsSinceEpoch(widget.order.orderedAt);
    if (currentStep > 1) {
      shippedDate = DateFormat('EEEE, d MMMM').format(orderDate.add(const Duration(days: 1, hours: 8)));
    }
    if (currentStep > 2) {
      deliveryDate = DateFormat('EEEE, d MMMM').format(orderDate.add(const Duration(days: 2, hours: 16)));
    }
    if (currentStep > 3) {
      arrivalDate = DateFormat('EEEE, d MMMM').format(orderDate.add(const Duration(days: 5)));
    }
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CommonAppbar(),
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "View order Details",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order Date: ${DateFormat('EEEE, d MMMM y h:mm a').format(orderDate)}",
                    ),
                    Text("Order Id: ${widget.order.id}"),
                    Text("Order Total: ₹${widget.order.totalPrice}"),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Purchase Details",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < widget.order.products.length; i++)
                      Row(
                        children: [
                          Image.network(
                            widget.order.products[i].images[0],
                            height: height * 0.185,
                            width: height * 0.185,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.order.products[i].name,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "Qty: ${widget.order.quantity[i]}",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Tracking",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: height * 0.45,
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Stepper(
                  physics: const BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.fast),
                  controlsBuilder: (context, details) {
                    if (currentStep != 4) {
                      if (user.type == "admin") {
                        return Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: CustomButton(
                            text: "Done",
                            onTap: () {
                              updateStatus();
                            },
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    } else {
                      return const SizedBox();
                    }
                  },
                  currentStep: currentStep - 1,
                  steps: [
                    Step(
                      title: Text("Ordered ${DateFormat('EEEE, d MMMM').format(orderDate)}"),
                      content: Text("Your order has been placed on ${DateFormat('h:mm a EEEE, d MMMM').format(orderDate)}"),
                      isActive: currentStep > 0,
                      state: currentStep > 0 ? StepState.complete : StepState.indexed,
                    ),
                    Step(
                      title: Text("Shipped $shippedDate"),
                      content: Text("The package has left the facility at ${DateFormat('h:mm a EEEE, d MMMM').format(orderDate.add(const Duration(days: 1, hours: 8, minutes: 15)))}"),
                      isActive: currentStep > 1,
                      state: currentStep > 1 ? StepState.complete : StepState.indexed,
                    ),
                    Step(
                      title: Text("Out For Delivery $deliveryDate"),
                      content: Text("Your order has reached Amazon facility of your city at ${DateFormat('h:mm a EEEE, d MMMM').format(orderDate.add(const Duration(days: 2, hours: 16, minutes: 38)))} and will be out for dilevery."),
                      isActive: currentStep > 2,
                      state: currentStep > 2 ? StepState.complete : StepState.indexed,
                    ),
                    Step(
                      title: Text("Arriving $arrivalDate"),
                      content: const Text("Your order has been delivered and received by you."),
                      isActive: currentStep > 3,
                      state: currentStep > 3 ? StepState.complete : StepState.indexed,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
