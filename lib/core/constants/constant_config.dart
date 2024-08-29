import 'package:flutter_dotenv/flutter_dotenv.dart';

class ConstantConfig {
  final String baseUrl = dotenv.get('BASE_URL');
  final String baseUrlApi = dotenv.get('BASE_URL_API');
  final String baseUrlApiV2 = dotenv.get('BASE_URL_API_V2');
  final String baseUrlAssets = dotenv.get('BASE_URL_ASSETS');
  final String baseUrlPmt = dotenv.get('BASE_URL_PMT');
  final String urlGeonodeLayers = dotenv.get('URL_GEONODE_LAYERS');
  final String mapUrl = dotenv.get('MAP_URL');
  final String mapboxAccessToken = dotenv.get('MAPBOX_ACCESS_TOKEN');
  final String mapboxConfig = dotenv.get('MAPBOX_CONFIG');
  final String type = dotenv.get('TYPE');
  final String buildLogEnabledMode = dotenv.get('BUILD_LOG_ENABLED_MODE');
  final String debugPreview = dotenv.get('DEBUG_PREVIEW');
}
