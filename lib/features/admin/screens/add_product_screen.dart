import 'dart:io';

import 'package:amazno_clone/common/widgets/custom_button.dart';
import 'package:amazno_clone/common/widgets/custom_textfield.dart';
import 'package:amazno_clone/constants/global_variables.dart';
import 'package:amazno_clone/constants/method_constants.dart';
import 'package:amazno_clone/constants/utils.dart';
import 'package:amazno_clone/features/admin/services/admin_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quanitityController = TextEditingController();
  final TextEditingController sellerNameController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController featuresController = TextEditingController();
  final AdminServices services = AdminServices();
  final _addProductFormKey = GlobalKey<FormState>();
  String category = "Mobiles";
  @override
  void dispose() {
    // TODO: implement dispose
    priceController.dispose();
    productNameController.dispose();
    discountController.dispose();
    quanitityController.dispose();
    descriptionController.dispose();
    sellerNameController.dispose();
    featuresController.dispose();
    super.dispose();
  }

  List<File> images = [];

  List<String> productCategories = [
    "Mobiles",
    "Essentials",
    "Books",
    "Fashion",
    "Appliances",
  ];

  void sellProduct() {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      services.sellProduct(
          context: context,
          features: featuresController.text,
          name: productNameController.text,
          description: descriptionController.text,
          price: double.parse(priceController.text.replaceAll(",", "")),
          quantity: int.parse(quanitityController.text),
          discount: int.parse(discountController.text),
          category: category,
          images: images,
          sellerName: sellerNameController.text);
    }
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: const Text(
            "Add Product",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                images.isNotEmpty
                    ? CarouselSlider(
                        items: images
                            .map(
                              (e) => Builder(
                                builder: (context) => Image.file(
                                  e,
                                  fit: BoxFit.fitHeight,
                                  height: 160,
                                ),
                              ),
                            )
                            .toList(),
                        options: CarouselOptions(
                          viewportFraction: 1,
                          height: 160,
                        ),
                      )
                    : GestureDetector(
                        onTap: () => selectImages(),
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.folder_open,
                                  size: 40,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Select Product Images",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextField(
                  type: TextInputType.text,
                  textEditingController: productNameController,
                  hintText: "Product Name",
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  type: TextInputType.multiline,
                  textEditingController: descriptionController,
                  hintText: "Description",
                  maxLines: 7,
                ),
                const SizedBox(
                  height: 10,
                ),
                if (category == "Mobiles" || category == "Appliances")
                  Column(
                    children: [
                      CustomTextField(
                        type: TextInputType.multiline,
                        textEditingController: featuresController,
                        hintText: "Features",
                        maxLines: 20,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                CustomTextField(
                  type: TextInputType.number,
                  formatter: [
                    ThousandsSeparatorInputFormatter(),
                  ],
                  textEditingController: priceController,
                  hintText: "Price",
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  type: TextInputType.number,
                  textEditingController: quanitityController,
                  hintText: "Quantity",
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  formatter: [
                    LengthLimitingTextInputFormatter(2),
                  ],
                  type: TextInputType.number,
                  textEditingController: discountController,
                  hintText: "Discount Percentage",
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  type: TextInputType.name,
                  autoFillHints: const [AutofillHints.name],
                  textEditingController: sellerNameController,
                  hintText: "Seller Name",
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton<String>(
                    value: category,
                    onChanged: (value) {
                      setState(() {
                        category = value!;
                      });
                    },
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: productCategories
                        .map(
                          (item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          ),
                        )
                        .toList(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(text: "Sell", onTap: sellProduct),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
