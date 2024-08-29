library core_18n;

import 'dart:io';

import 'package:language/src/class/generate_i18n_constant_manifest.dart';
import 'package:language/src/utilities/extra_json_file_utilities.dart';
import 'package:language/src/utilities/print_utilities.dart';
import 'package:path/path.dart' as path;

class I18nOption {
  late String sourceDir;
  late String templateLocale;
  late String outputDir;

  @override
  String toString() {
    return 'I18nOption{sourceDir: $sourceDir, templateLocale: $templateLocale, outputDir: $outputDir}';
  }
}

/**
 * Task :
 * 1. Generate string_i18n_copies_all.dart
 * 2. Generate string_i18n_constant_manifest.dart
 * 3. Generate string_i18n_generated_manifest.dart
 */
void handleGenerateAllI18nFiles(I18nOption option) async {
  Directory current = Directory.current;

  var sourcePath = Directory(path.join(current.path, option.sourceDir));
  if (!await sourcePath.exists()) {
    printError('Source path does not exist');
    return;
  }

  List<FileSystemEntity> files =
      await dirContents(Directory(path.join(current.path, option.sourceDir)));
  Map<String, FileSystemEntity> validFilesMap = getValidStringFileMap(files);
  FileSystemEntity? defaultTemplateLang =
      getDefaultTemplateLang(validFilesMap, option.templateLocale);
  if (null != defaultTemplateLang) {
    Map<String, Message> defaultJsonKeyMessageMap =
        await generateJsonKeyMessageMap(File(defaultTemplateLang.path));

    String defaultLang = path.basename(getLocale(defaultTemplateLang.path));

    _handleGenerateConstantDartFile(
      path.join(
          current.path, option.outputDir, 'string_i18n_constant_manifest.dart'),
      defaultLang,
      defaultJsonKeyMessageMap,
      validFilesMap,
    );

    printInfo('Finished to generate 3 files.');
  }
}

/**
 * Task :
 * 1. Generate all copies Constant
 * 2. Generate supported locale
 * 3. Generate string_i18n_constant_manifest.dart
 */
void _handleGenerateConstantDartFile(
    String path,
    String defaultLang,
    Map<String, Message> defaultKeyMap,
    Map<String, FileSystemEntity> validFilesMap) async {
  File generatedFile = File(path);
  if (!generatedFile.existsSync()) {
    generatedFile.createSync(recursive: true);
  }

  _writeConstant(
    StringBuffer constantBuilder,
  ) {
    for (MapEntry<String, Message> entity in defaultKeyMap.entries) {
      String jsonKey = entity.key;
      final _jsonKey = jsonKey.toUpperCase();
      constantBuilder.writeln(generateConstantString(_jsonKey, jsonKey));
    }
  }

  _writeLocale(
    StringBuffer supportedLangBuilder,
  ) {
    supportedLangBuilder.writeln(generateLocale(defaultLang));

    for (var locale in validFilesMap.keys) {
      if (locale != defaultLang) {
        supportedLangBuilder.writeln("${generateLocale(locale).trim()}");
      }
    }
  }

  StringBuffer constantBuilder = StringBuffer();
  StringBuffer supportedLangBuilder = StringBuffer();

  _writeConstant(constantBuilder);
  _writeLocale(supportedLangBuilder);

  generatedFile.writeAsStringSync(generateConstantStringAndLocaleDartFile(
      constantBuilder.toString(), supportedLangBuilder.toString()));
}
