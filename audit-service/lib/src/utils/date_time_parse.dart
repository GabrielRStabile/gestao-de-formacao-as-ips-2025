import 'package:vaden/vaden.dart';

/// Custom parser for DateTime objects in DTOs
///
/// Provides safe conversion between DateTime objects and ISO 8601 strings
/// for JSON serialization/deserialization in audit logs.
@Parse()
class DateTimeParse extends ParamParse<DateTime?, String> {
  /// Creates a new instance of DateTimeParse
  const DateTimeParse();

  /// Converts a DateTime to ISO 8601 string format
  ///
  /// [param] The DateTime to convert
  /// Returns ISO 8601 string or empty string if null
  @override
  String toJson(DateTime? param) {
    return param?.toIso8601String() ?? '';
  }

  /// Parses an ISO 8601 string to DateTime
  ///
  /// [json] The ISO 8601 string to parse
  /// Returns the parsed DateTime or null if parsing fails
  @override
  DateTime? fromJson(String? json) {
    return DateTime.tryParse(json ?? '');
  }
}
