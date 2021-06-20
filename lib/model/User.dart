class OurUser{
  String uid;
  String fullName;
  String email;


  String profilePhoto;

  OurUser({
    this.uid,
    this.fullName,
    this.email,
    this.profilePhoto,

  }
      );
  Map toMap(OurUser user){
    var data=Map<String,dynamic>();
    data['uid']=user.uid;
    data['fullName']=user.fullName;
    data['email']=user.email;

    data['profilePhoto']=user.profilePhoto;


    return data;

  }
  OurUser.fromMap(Map<String,dynamic>map){
    this.uid=map['uid'];
    this.fullName=map['fullName'];
    this.email=map['email'];
    this.profilePhoto=map['profilePhoto'];

  }
}