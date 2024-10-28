class UserModel {
  final String id;
  final String name;
  final String email;
  final String contactNum;
  final String subject;
  final String school;
  final String image;

  UserModel({required this.id, required this.name,required this.email,required this.contactNum, required this.subject,required this.school,required this.image});

  factory UserModel.fromJson(Map<String, dynamic> data) =>
      UserModel(
          id: data['id'],
          name: data['name'],
          email: data['email'],
          contactNum: data['contactNum'],
          subject: data['subject'],
          school: data['school'],
          image: data['image']

      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'email': email,
        'contactNum': contactNum,
        'subject': subject,
        'school': school,
        'image':image
      };
}
