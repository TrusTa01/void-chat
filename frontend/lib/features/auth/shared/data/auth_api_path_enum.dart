enum AuthApiPathEnum {
  me('/auth/me'),

  loginPass('/auth/login/password'),
  loginCodeReq('/auth/login/code/request'),
  loginCodeVerify('/auth/login/code/verify'),

  registerStart('/auth/register/start'),
  registerVerify('/auth/register/verify-email'),
  registerProfile('/auth/register/complete-profile'),
  registerCancel('/auth/register/cancel'),

  logout('/auth/logout'),
  logoutAll('/auth/logout/all');

  final String path;
  const AuthApiPathEnum(this.path);
}
