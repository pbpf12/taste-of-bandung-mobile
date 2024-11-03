
import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:tasteofbandung/core/environments/_environments.dart';
import 'package:either_dart/either.dart';

import '../models/dish_model.dart';
import 'package:http/http.dart' as http;

part 'search_remote_data_source_impl.dart';
part 'search_remote_data_source.dart';