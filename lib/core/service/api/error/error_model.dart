class ErrorModel {
  final String message;
  const ErrorModel({required this.message});

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      message: json['status_message'] ?? 'An unknown error occurred',
    );
  }
}
