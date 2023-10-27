import 'package:amazno_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      height: 30,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(198, 118, 237, 231),
            Color.fromARGB(233, 163, 238, 235),
          ],
          stops: [0.5, 1.0],
        ),
      ),
      padding: const EdgeInsets.only(
        left: 10,
      ),
      child: Row(
        children: [
          const Icon(
            Icons.location_on,
            size: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                "Delivery to ${user.name} - ${user.address}",
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 5,
              top: 2,
            ),
            child: Icon(
              Icons.arrow_drop_down,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}
