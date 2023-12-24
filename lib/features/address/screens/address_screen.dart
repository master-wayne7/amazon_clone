import 'package:amazno_clone/common/widgets/custom_button.dart';
import 'package:amazno_clone/common/widgets/custom_textfield.dart';
import 'package:amazno_clone/common/widgets/payments_bottom_sheet.dart';
import 'package:amazno_clone/constants/global_variables.dart';
import 'package:amazno_clone/constants/utils.dart';
import 'package:amazno_clone/features/address/services/address_services.dart';
import 'package:amazno_clone/models/user.dart';
import 'package:amazno_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = "/address";
  final String totalAmount;
  const AddressScreen({super.key, required this.totalAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final AddressServices addressServices = AddressServices();
  final _addressFormKey = GlobalKey<FormState>();
  final TextEditingController _houseNoController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _localityController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _houseNoController.dispose();
    _cityController.dispose();
    _localityController.dispose();
    _pinCodeController.dispose();
    _streetController.dispose();
    _stateController.dispose();
  }

  late Address addressToBeUsed;

  void payPressed(Address addressFromPovider) {
    bool isform = _houseNoController.text.isNotEmpty ||
        _streetController.text.isNotEmpty ||
        _localityController.text.isNotEmpty ||
        _stateController.text.isNotEmpty ||
        _pinCodeController.text.isNotEmpty ||
        _cityController.text.isNotEmpty;
    if (isform) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed = Address(
            houseNo: int.parse(_houseNoController.text),
            street: _streetController.text,
            locality: _localityController.text,
            city: _cityController.text,
            state: _stateController.text,
            pincode: int.parse(_pinCodeController.text));
      } else {
        throw Exception("Please enter all values!");
      }
    } else if (addressFromPovider.city.isNotEmpty) {
      addressToBeUsed = addressFromPovider;
    } else {
      showSnackBar(context, "Enter your address for the delivery!");
    }
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address != null)
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Text(
                        "${address.houseNo}, ${address.street}, ${address.locality}, ${address.city} - ${address.pincode}",
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "OR",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                      textEditingController: _houseNoController,
                      hintText: "House no",
                      type: TextInputType.number,
                      formatter: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      textEditingController: _streetController,
                      hintText: "Street",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      textEditingController: _localityController,
                      hintText: "Locality",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      textEditingController: _cityController,
                      hintText: "Town/City",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      textEditingController: _stateController,
                      hintText: "State",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      textEditingController: _pinCodeController,
                      hintText: "Pincode",
                      type: TextInputType.number,
                      formatter: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(6),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              CustomButton(
                text: "Pay Using UPI",
                onTap: () {
                  payPressed(addressToBeUsed);
                  addressServices.saveUserAddress(
                      context: context, address: addressToBeUsed);
                  showModalBottomSheet(
                    enableDrag: true,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8))),
                    context: context,
                    builder: (context) => PaymentsBottomSheet(
                        amount: double.parse(widget.totalAmount)),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
