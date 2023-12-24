import 'package:amazno_clone/constants/global_variables.dart';
import 'package:amazno_clone/constants/method_constants.dart';
import 'package:amazno_clone/models/rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewWidget extends StatelessWidget {
  final Rating rating;
  const ReviewWidget({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.person_outline_rounded,
                  size: 36,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                rating.userName,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RatingBar.builder(
                onRatingUpdate: (value) {},
                initialRating: rating.rating,
                ignoreGestures: true,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 20,
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: GlobalVariables.secondaryColor,
                ),
              ),
              const SizedBox(width: 5),
              const Text(
                "Verified Purchase",
                style: TextStyle(
                  color: Color(0xffa95a12),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            rating.reviewHeading,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            "Reviewed in India on ${MethodConstants.formatDateRating(rating.reviewTime.toInt())}",
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Colors.grey[600]),
          ),
          const SizedBox(height: 5),
          Text(
            rating.review,
            overflow: TextOverflow.ellipsis,
            maxLines: 6,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: height * 0.05,
                width: width * 0.26,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black12),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 1),
                  ],
                ),
                child: const Center(
                  child: Text(
                    "Helpful",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.share_outlined),
              const Text(
                "Share",
                style: TextStyle(fontSize: 16),
              ),
              const Spacer(),
              const Text(
                "Report",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
