abstract interface class ISessionRepository {
  Future<void> create(String userId, String tokenHash, DateTime expiresAt);
  Future<String?> findUserIdByTokenHash(String tokenHash);
  Future<void> deleteTokenByHash(String tokenHash);
  Future<void> deleteAllByUserId(String userId);
}
