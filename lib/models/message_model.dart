// class MessageModel {
//   final String message;
//   final String senderEmail;

//   MessageModel({required this.message, required this.senderEmail});

//   factory MessageModel.fromJson(jsonData) {
//     return MessageModel(
//       message: jsonData['message'],
//       senderEmail: jsonData['senderEmail'],
//     );
//   }
// }



class MessageModel {
  final String message;
  final String senderEmail;

  MessageModel({
    required this.message,
    required this.senderEmail,
  });

  factory MessageModel.fromJson(Map<String, dynamic> jsonData) {
    return MessageModel(
      message: jsonData['message']?.toString() ?? '',
      senderEmail: jsonData['senderEmail']?.toString() ?? '',
    );
  }
}