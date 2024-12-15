import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:tasteofbandung/core/environments/_environments.dart';
import 'package:either_dart/either.dart';

import '../../../search/data/models/dish_model.dart';
import '../models/history_model.dart';
import '../models/user_model.dart';

part 'profile_remote_data_source_impl.dart';
part 'profile_remote_data_source.dart';