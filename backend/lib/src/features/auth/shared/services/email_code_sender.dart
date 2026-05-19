abstract interface class EmailCodeSenderService {
  Future<void> send(String email, String code);
}
