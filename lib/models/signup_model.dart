class SignupModel{
  final String email;
  final String mobile;
  final String password;

  SignupModel({required this.email,required this.mobile,required this.password});

  Map<String,dynamic> toMap(){
    return {
      'email':email,
      'mobile':mobile,
      'password':password
    };
  }
}