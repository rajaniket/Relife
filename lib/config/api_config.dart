class ApiConfig {
  static const appName = 'Relife';
  static const baseUrl =
      'relife.co.in'; //'relife.co.in';  //'test.relife.co.in'
  static const loginEndpoint = '/api/login';
  static const getProfileEndpoint = '/api/user/profile';
  static const updateProfileEndpoint = '/api/user/profile';
  static const getDpEndpoint = '/api/user/profilePicture';
  static const setDpEndpoint = '/api/user/profilePicture';
  static const forgotPasswordEndpoint = '/api/forgotPassword';
  static const resetPasswordEndpoint = '/api/passwordReset';
  static const updateDpEndpoint = '/api/user/profilePicture';
  static const getWaitlistUserEndpoint = '/api/user/waitlist';
  static const waitlistRegisterEndpoint = '/api/user/register';
  static const createUserHabitEndpoint = '/api/userHabits/create';
  static const updateUserHabitEndpoint =
      '/api/userHabits/update'; // (my) particular habit of a user  // require habit id
  static const getStystemAllHabitEndpoint =
      '/api/habit/view/all'; //  (common) all system habit
  static const getUserAllHabitEndpoint =
      '/api/userHabits/view/all'; // (my) all habits of a user (doesn't require user id)
  static const getParticukarSystemHabitEndpoint =
      '/api/habit/update'; //(common) particular system habit (doesn't include any particular user's info)   //require habit id
  static const paymentEndpoint = '/api/razorpay/createSubscription';
  static const paymentDetailsEndpoint = '/api/razorpay/getSubscriptionDetails';
  static const cancleSubEndpoint = '/api/razorpay/cancelSubscription';
}
