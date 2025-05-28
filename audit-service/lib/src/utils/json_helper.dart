import 'dart:convert';

/// Utility class for working with JSON in audit logs
///
/// Provides safe JSON serialization and deserialization methods
/// with proper error handling for audit log data.
class JsonHelper {
  /// Converts a Map to a JSON string
  ///
  /// [map] The map to convert to JSON
  /// Returns the JSON string representation or null if conversion fails
  static String? mapToJsonString(Map<String, dynamic>? map) {
    if (map == null || map.isEmpty) return null;

    try {
      return jsonEncode(map);
    } catch (e) {
      return null;
    }
  }

  /// Converts a JSON string to a Map
  ///
  /// [jsonString] The JSON string to parse
  /// Returns the parsed Map or null if parsing fails
  static Map<String, dynamic>? jsonStringToMap(String? jsonString) {
    if (jsonString == null || jsonString.isEmpty) return null;

    try {
      final decoded = jsonDecode(jsonString);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Validates if a string is valid JSON
  ///
  /// [jsonString] The string to validate
  /// Returns true if the string is valid JSON, false otherwise
  static bool isValidJson(String? jsonString) {
    if (jsonString == null || jsonString.isEmpty) return false;

    try {
      jsonDecode(jsonString);
      return true;
    } catch (e) {
      return false;
    }
  }
}
