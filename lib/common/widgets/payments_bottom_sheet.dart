import 'package:amazno_clone/constants/global_variables.dart';
import 'package:amazno_clone/providers/payment_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upi_india/upi_app.dart';
import 'package:upi_india/upi_india.dart';

class PaymentsBottomSheet extends StatelessWidget {
  final double amount;
  const PaymentsBottomSheet({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    var paymentsProvider = Provider.of<PaymentProvider>(context);
    if (paymentsProvider.apps == null) {
      return const Center(child: CircularProgressIndicator());
    } else if (paymentsProvider.apps!.isEmpty) {
      return const Center(
        child: Text(
          "No apps found to handle transaction.",
          // style: header,
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8), topRight: Radius.circular(8)),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.800000011920929),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0F000000),
                      blurRadius: 2,
                      offset: Offset(0, 2),
                      spreadRadius: 0,
                    )
                  ],
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Pay through UPI',
                      style: TextStyle(color: Color(0xFF1D1B20), fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    runSpacing: 10,
                    spacing: 10,
                    children: paymentsProvider.apps!.map<Widget>(
                      (UpiApp app) {
                        return GestureDetector(
                          onTap: () {
                            paymentsProvider.setTransaction(
                                app, context, amount);
                          },
                          child: SizedBox(
                            height: height * 0.09,
                            width: height * 0.09,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.memory(
                                  app.icon,
                                  height: height * 0.05,
                                  width: height * 0.05,
                                ),
                                Text(app.name),
                              ],
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
