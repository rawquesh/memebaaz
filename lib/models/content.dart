import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot, Timestamp;
// import 'package:meme_baaz/ads/const.dart';

class ContentModel {
  String? id;
  DateTime? dateUploaded;
  String? title;
  String? type;
  String? url;
  String? status;
  List<String>? tags;
  int? likes;
  int? random;
  double? size;
  double? aspectRatio;

  ContentModel({
    this.id,
    this.dateUploaded,
    this.title,
    this.type,
    this.url,
    this.status,
    this.tags,
    this.likes,
    this.size,
    this.random,
    this.aspectRatio,
  });

  ContentModel.fromSnapshot(DocumentSnapshot doc) {
    id = doc.id;
    dateUploaded = (doc['date_uploaded'] as Timestamp).toDate();
    title = doc['title'];
    type = doc['type'];
    url = doc['url'];
    status = doc['status'];
    tags = doc['tags'].cast<String>();
    likes = doc['likes'];
    size = doc['size'];
    aspectRatio = doc['aspect_ratio'];
    random = Random().nextInt(0);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['date_uploaded'] = dateUploaded;
    data['title'] = title;
    data['type'] = type;
    data['url'] = url;
    data['status'] = status;
    data['tags'] = tags;
    data['likes'] = likes;
    data['size'] = size;
    data['aspect_ratio'] = aspectRatio;
    return data;
  }
}

mixin ContentStatus {
  static String verified = 'verified';
  static String hold = 'hold';
  static String pending = 'pending';
}
