import 'package:assets/src/generator/generator.dart';
import 'package:assets/src/model/dart_class.dart';
import 'package:assets/src/model/resources.dart';

List<DartClass?> generateAssetsClass(List<Asset> assets) {
  return [
    _generateAssetConstantsClass(
        assets.where((item) => item.type == AssetType.stringPath).toList()),
    _generateAssetLottieClass(
        assets.where((item) => item.type == AssetType.lottie).toList()),
    _generateImageAssetsClass(
        assets.where((item) => item.type == AssetType.image).toList())
  ].where((it) => it != null).toList();
}

DartClass? _generateAssetLottieClass(List<Asset> assets) {
  if (assets.isEmpty) {
    return null;
  }

  final imports = <String>{};

  final classString = StringBuffer("class LottieManifest {\n  LottieManifest._();\n");
  for (final asset in assets) {
    // classString.write(createComment(asset));
    classString.write(
        "  static AssetLottie get ${createVariableName(asset.name ?? '')} => AssetLottie(\"${asset.path}\"");
    if (asset.package != null) {
      classString.write(", package: \"${asset.package}\"");
    }
    classString.writeln(");");
  }
  classString.writeln("}");
  return DartClass(
    imports: ["package:flutter/widgets.dart"],
    code: classString.toString(),
  );
}

DartClass? _generateAssetConstantsClass(List<Asset> assets) {
  if (assets.isEmpty) {
    return null;
  }

  final imports = <String>{};

  final classString = StringBuffer("class AssetCombinedManifest {\n  AssetCombinedManifest._();\n");
  for (final asset in assets) {
    final type = asset.type;
    if (type is CustomAssetType) {
      imports.add(type.import);
      final custom = type.customClass;
      classString.writeln(
          "  static const $custom ${createVariableName(asset.name ?? '').toUpperCase()} = $custom(\"${(asset.path ?? '').replaceAll("../", "")}\");");
    } else {
      classString.writeln(
          "  static const String ${createVariableName(asset.name ?? '')} = \"${(asset.path ?? '').replaceFirst("../", "")}\";");
    }
  }
  classString.writeln("}");
  return DartClass(
      code: classString.toString(), imports: imports.toList()..sort());
}

DartClass? _generateImageAssetsClass(List<Asset> assets) {
  if (assets.isEmpty) {
    return null;
  }
  final classString = StringBuffer("class ImageManifest {\n  ImageManifest._();\n");
  for (final asset in assets) {
    // classString.write(createComment(asset));
    classString.write(
        "  static AssetImage get ${createVariableName(asset.name ?? '')} => const AssetImage(\"${asset.path}\"");
    if (asset.package != null) {
      classString.write(", package: \"${asset.package}\"");
    }
    classString.writeln(");");
  }
  classString.writeln("}");
  return DartClass(
    imports: ["package:flutter/widgets.dart"],
    code: classString.toString(),
  );
}

bool isExample = false;

String createComment(Asset asset) {
  String path = asset.fileUri ?? '';

  const examplePath = 'assets/example/';

  isExample ??= path.contains(examplePath);

  // a hack to prevent commited assets.dart from changing constantly
  if (isExample) {
    path = path.substring(path.indexOf(examplePath) + examplePath.length);
    path = 'file:///Users/user/path/$path';
  }

  return "  /// ![]($path)\n";
}
