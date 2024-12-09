import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:tasteofbandung/core/environments/_environments.dart';
import 'package:either_dart/either.dart';

import '../models/history_model.dart';
import '../models/user_model.dart';
import 'package:http/http.dart' as http;

part 'profile_remote_data_source_impl.dart';
part 'profile_remote_data_source.dart';