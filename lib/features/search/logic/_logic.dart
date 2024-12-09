import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tasteofbandung/features/search/data/datasources/_datasources.dart';
import 'package:tasteofbandung/features/search/data/models/dish_model.dart';
import 'package:equatable/equatable.dart';

part 'search_cubit.dart';
part 'search_state.dart';