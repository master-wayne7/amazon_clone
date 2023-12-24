// ignore_for_file: use_build_context_synchronously

import 'package:amazno_clone/constants/utils.dart';
import 'package:amazno_clone/features/address/services/address_services.dart';
import 'package:amazno_clone/models/product.dart';
import 'package:amazno_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upi_india/upi_india.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'dart:typed_data';

class PaymentProvider extends ChangeNotifier {
  List<UpiApp>? _apps;
  UpiResponse? _transaction;
  AddressServices _addressServices = AddressServices();

  final UpiIndia _upiIndia = UpiIndia();
  UpiIndia get upiIndia => _upiIndia;
  List<UpiApp>? get apps => _apps;
  UpiResponse? get transactions => _transaction;

  void getApps() {
    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      setApps(value);
    }).catchError((e) {
      setApps([]);
    });
  }

  void setApps(List<UpiApp>? appsAvailable) {
    _apps = appsAvailable;
    notifyListeners();
  }

  void setTransaction(
      UpiApp app, BuildContext context, double totalPrice) async {
    try {
      UpiResponse res = await _upiIndia.startTransaction(
        app: app,
        receiverUpiId: "ronitrameja28@okaxis",
        receiverName: 'Ronit Rameja',
        transactionRefId: 'TestingUpiPaymentForBuy',
        transactionNote: 'Payment for the products bought from Amazon Clone',
        amount: totalPrice,
      );
      _transaction = res;

      if (_transaction!.status != UpiPaymentStatus.SUCCESS) {
        showSnackBar(context, checkTxnStatus(_transaction!.status!));
      } else {
        showSnackBar(context, 'Transaction Successful');
        await _addressServices.placeOrder(
            context: context,
            address:
                Provider.of<UserProvider>(context, listen: false).user.address!,
            totalSum: totalPrice);
      }
      Navigator.pop(context);
    } on UpiIndiaAppNotInstalledException {
      Navigator.pop(context);
      showSnackBar(context, 'Requested app not installed on device');
    } on UpiIndiaUserCancelledException {
      Navigator.pop(context);
      showSnackBar(context, 'You cancelled the transaction');
    } on UpiIndiaNullResponseException {
      Navigator.pop(context);
      showSnackBar(context, 'Requested app didn\'t return any response');
    } on UpiIndiaInvalidParametersException {
      Navigator.pop(context);
      showSnackBar(context, 'Requested app cannot handle the transaction');
    } catch (e) {
      Navigator.pop(context);
      showSnackBar(context, e.toString());
    }
    notifyListeners();
  }

  // String upiErrorHandler(error) {
  //   switch (error) {
  //     case UpiIndiaAppNotInstalledException:
  //       return 'Requested app not installed on device';
  //     case UpiIndiaUserCancelledException:
  //       return 'You cancelled the transaction';
  //     case UpiIndiaNullResponseException:
  //       return 'Requested app didn\'t return any response';
  //     case UpiIndiaInvalidParametersException:
  //       return 'Requested app cannot handle the transaction';
  //     default:
  //       return 'An Unknown error has occurred';
  //   }
  // }

  String checkTxnStatus(String status) {
    switch (status) {
      case UpiPaymentStatus.SUCCESS:
        return 'Transaction Successful';
      case UpiPaymentStatus.SUBMITTED:
        return 'Transaction Submitted';
      case UpiPaymentStatus.FAILURE:
        return 'Transaction Failed';
      default:
        return 'Received an Unknown transaction status';
    }
  }

  Future<void> generateAndSaveInvoice(List<Product> products) async {
    // Generate the invoice as PDF
    final Uint8List pdfBytes = await generateInvoice(products);

    // Get the local app storage directory
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String appDocPath = appDocDir.path;

    // Create a file in the app storage directory
    final File file = File('$appDocPath/invoice.pdf');

    // Write the PDF content into the file
    await file.writeAsBytes(pdfBytes);

    // Provide the file path to the user
    final String downloadUrl = file.path;

    // You can now use this downloadUrl to provide a link to the user for downloading the invoice
    print('Invoice generated and saved: $downloadUrl');
  }

  Future<Uint8List> generateInvoice(List<Product> products) async {
    final pdf = pw.Document();

    // Add content to the PDF
    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Center(
            child: pw.Text('Sample Invoice', style: pw.TextStyle(fontSize: 24)),
          );
        },
      ),
    );

    // Save the PDF to a Uint8List
    return pdf.save();
  }
}
