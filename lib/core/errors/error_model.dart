class ErrorModel {
  final String detail;

  ErrorModel({required this.detail});

  factory ErrorModel.fromJson(dynamic jsonData) {
    String detailMessage;

    if (jsonData is String) {
      detailMessage = 'Somthing went wrong , please try again later';
    } else if (jsonData is Map<String, dynamic>) {
      if (jsonData.containsKey('message')) {
        if (jsonData['message'] is String) {
          // Handle case where message is a string
          detailMessage = jsonData['message'];
        } else if (jsonData['message'] is Map<String, dynamic>) {
          // Handle case where message is a map
          final firstEntry =
              (jsonData['message'] as Map<String, dynamic>).entries.first;
          detailMessage = firstEntry.value.first;
        } else {
          // Default fallback for unexpected types
          detailMessage = 'Somthing went wrong , please try again later';
          ';';
        }
      } else {
        // Default message if neither errors nor message are found
        detailMessage = 'Somthing went wrong , please try again later';
        ';';
      }
    } else {
      detailMessage = 'Somthing went wrong , please try again later';
    }

    return ErrorModel(detail: detailMessage);
  }
}
