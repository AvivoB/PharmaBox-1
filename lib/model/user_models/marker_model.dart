import 'dart:convert';

import 'package:equatable/equatable.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class MarkerModel extends Equatable{
  final double lat;
  final double lng;
  int count;
  MarkerModel({
    required this.lat,
    required this.lng,
    required this.count,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lat': lat,
      'lng': lng,
      'count': count,
    };
  }

  factory MarkerModel.fromMap(Map<String, dynamic> map) {
    return MarkerModel(
      lat: map['lat'] as double,
      lng: map['lng'] as double,
      count: map['count'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory MarkerModel.fromJson(String source) => MarkerModel.fromMap(json.decode(source) as Map<String, dynamic>);
  
  @override
  // TODO: implement props
  List<Object?> get props => [lat,lng,count];
}
