class FirebaseExceptionHandler {
  static handleException(e) {
    switch (e.code) {
      case 'auth/weak-password':
        return 'The password is too weak.';

      case 'auth/email-already-in-use':
        return 'The email is already in use by another account.';

      case 'auth/invalid-email':
        return 'The email address is invalid.';

      case 'auth/user-not-found':
        return 'The user was not found.';

      case 'auth/wrong-password':
        return 'The password is incorrect.';

      case 'storage/unauthorized':
        return 'User is not authorized to perform the desired action.';

      case 'storage/canceled':
        return 'The user canceled the operation.';

      case 'storage/unknown':
        return 'An unknown error occurred.';

      case 'firestore/permission-denied':
        return 'The user does not have permission to access the desired resource.';

      case 'firestore/unavailable':
        return 'The Firestore server is unavailable.';

      case 'firestore/failed-precondition':
        return 'The operation could not be executed due to a failed precondition.';

      case 'firestore/aborted':
        return 'The operation was aborted, typically due to a concurrency issue.';

      case 'firestore/unauthenticated':
        return 'The user is not authenticated, so the operation could not be executed.';

      default:
        return 'An unknown error occurred: ${e.message}';
    }
  }
}
