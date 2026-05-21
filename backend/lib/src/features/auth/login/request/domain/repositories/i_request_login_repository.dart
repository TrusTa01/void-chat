abstract interface class IRequestLoginRepository {
  Future<void> insertCode({
    required String userId,
    required String codeHash,
    required DateTime expiresAt,
  });
  Future<DateTime?> findLastCodeCreatedAt(String userId);
}
