
class SignUpWithEmailAndpasswordFailure{
  final String message;
  const SignUpWithEmailAndpasswordFailure([this.message = "An Unknown Error occured"]);

  factory SignUpWithEmailAndpasswordFailure.code(String code){
    switch(code){
      case('weak-password') : return SignUpWithEmailAndpasswordFailure('Please enter a stronger password ');
      case('invalid-email') : return SignUpWithEmailAndpasswordFailure('Please enter a valid email');
      case('email-already-in-use') : return SignUpWithEmailAndpasswordFailure('An account already exsist with this email address');
      case('operation-not-allowed') : return SignUpWithEmailAndpasswordFailure('Operation is not allowed. Please contact for support');
      case('user-disabled') : return SignUpWithEmailAndpasswordFailure('This account has been diabbled. Please contact for support');
      default: return SignUpWithEmailAndpasswordFailure();
    }
  }
}