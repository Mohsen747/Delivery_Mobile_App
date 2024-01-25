// ignore_for_file: file_names

import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<dynamic>> fetchGifts() async {
    final response = await _dio.get('https://fakestoreapi.com/products');
    return response.data;
  }

  Future<List<dynamic>> fetchPlants() async {
    final response = await _dio.get('https://mocki.io/v1/419a7bd1-ac33-4177-acec-294b0177aec5');
    return response.data;
  }
}
