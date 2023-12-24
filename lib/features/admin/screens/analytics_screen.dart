import 'package:amazno_clone/common/widgets/loader.dart';
import 'package:amazno_clone/features/admin/model/sales_model.dart';
import 'package:amazno_clone/features/admin/services/admin_services.dart';
import 'package:amazno_clone/features/admin/widgets/category_charts.dart';
import 'package:flutter/material.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  int? totalSales;
  List<Sales>? earnings;
  final AdminServices adminServices = AdminServices();
  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  void getEarnings() async {
    var earningData = await adminServices.getEarnings(context);
    totalSales = earningData['totalEarning'];
    earnings = earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null
        ? const Loader()
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    height: MediaQuery.of(context).size.height * .51,
                    child: CategoryCharts(
                        sales: earnings!, totalEarnings: totalSales!)),
              ),
            ],
          );
  }
}
