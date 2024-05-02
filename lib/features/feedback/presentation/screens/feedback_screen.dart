import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:quikhyr_worker/common/quik_asset_constants.dart';
import 'package:quikhyr_worker/common/quik_colors.dart';
import 'package:quikhyr_worker/common/quik_spacings.dart';
import 'package:quikhyr_worker/common/quik_themes.dart';
import 'package:quikhyr_worker/common/widgets/clickable_svg_icon.dart';
import 'package:http/http.dart' as http;

import '../../../../common/quik_secure_constants.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<List<dynamic>> fetchData() async {
    final response = await http.get(Uri.parse(
        '$baseUrl/ratings?workerId=${FirebaseAuth.instance.currentUser!.uid}'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as List;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: AppBar(
              titleSpacing: 24,
              automaticallyImplyLeading: false, // Remove back button
              backgroundColor: Colors.transparent,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Q',
                          style:
                              TextStyle(fontFamily: 'Moonhouse', fontSize: 32),
                        ),
                        TextSpan(
                          text: 'uik',
                          style:
                              TextStyle(fontFamily: 'Moonhouse', fontSize: 24),
                        ),
                        TextSpan(
                          text: 'Feedback',
                          style: TextStyle(
                              fontFamily: 'Trap',
                              fontSize: 24,
                              letterSpacing: -1.5),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              actions: [
                ClickableSvgIcon(
                    svgAsset: QuikAssetConstants.filterSvg,
                    onTap: () {
                      debugPrint(DateTime.now().toIso8601String());
                      debugPrint(FirebaseAuth.instance.currentUser!.uid);
                    }),
                QuikSpacing.hS24(),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            FutureBuilder<List<dynamic>>(
              future: fetchData(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data![index];
                      return Column(
                        children: [
                          ListTile(
                            title: Text(
                              'Subservice Name: ${data['subserviceName']}',
                              style: workerListNameTextStyle,
                            ),
                            subtitle: Text(
                              'Feedback: ${data['overallRating']['feedback']}',
                              style: workerListNameTextStyle,
                            ),
                          ),
                          RatingBar.builder(
                            ignoreGestures: true,
                            tapOnlyMode: true,
                            initialRating:
                                data['overallRating']['rating'].toDouble(),
                            minRating: 1,
                            itemCount: 5,
                            itemBuilder: (context, _) =>
                                const Icon(Icons.star_rounded),
                            onRatingUpdate: (rating) {},
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ],
        ));
  }
}
