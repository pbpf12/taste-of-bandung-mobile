part of '_constants.dart';

class Assets {
  static final svg = _SvgAssets();
  static final image = _ImageAssets();
}

class _SvgAssets {
  final String _basePath = 'assets/svgs';

  String get svg1 => '$_basePath/svg1.svg';
}

class _ImageAssets {
  final String _basePath = 'assets/images';
  
  String get logo => '$_basePath/logo.png';
}
