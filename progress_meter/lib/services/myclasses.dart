class Member{

  Member();
}

class MemberProvider extends ChangeNotifier{
  Member? _currentMember;

  Member? get currenMember => _currentMember;

  void setCurrentMember(Member member){
    _currentMember = member;
    notifyListeners();
  }
}

Future<void> fetchdata(String uid)async{

  DocumentSnapshot usersnap = await FirebaseFirestore.instance.collection('users').doc(uid).get();
  if (usersnap.exists){
    // do something
  }
}