import 'package:vaden/vaden.dart';

/// DTO for enrollment event messages received from the enrollment service
///
/// Validates enrollment event data when a new student enrolls in a course.
/// This event triggers the creation of an issued certificate with PENDING_APPROVAL status.
@DTO()
class EnrollmentEventDto with Validator<EnrollmentEventDto> {
  /// ID of the trainee/student user who enrolled
  final String traineeUserId;

  /// ID of the enrollment record in the enrollment service
  final String enrollmentId;

  /// ID of the course the student enrolled in
  final String courseId;

  /// Timestamp when the enrollment occurred
  final String timestamp;

  const EnrollmentEventDto({
    required this.traineeUserId,
    required this.enrollmentId,
    required this.courseId,
    required this.timestamp,
  });

  @override
  LucidValidator<EnrollmentEventDto> validate(
    ValidatorBuilder<EnrollmentEventDto> builder,
  ) {
    return builder
      ..ruleFor(
        (r) => r.traineeUserId,
        key: 'traineeUserId',
      ).notEmptyOrNull().minLength(1).maxLength(100)
      ..ruleFor(
        (r) => r.enrollmentId,
        key: 'enrollmentId',
      ).notEmptyOrNull().minLength(1).maxLength(100)
      ..ruleFor(
        (r) => r.courseId,
        key: 'courseId',
      ).notEmptyOrNull().minLength(1).maxLength(100)
      ..ruleFor((r) => r.timestamp, key: 'timestamp').notEmptyOrNull();
  }
}
