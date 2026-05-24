/// Lowercase atoms compared case-insensitively against normalized login.
const Set<String> kReservedLogins = {
  'admin',
  'administrator',
  'root',
  'system',
  'support',
  'helpdesk',
  'help',
  'void',
  'moderator',
  'mod',
  'staff',
  'official',
  'team',
  'security',
  'api',
  'www',
  'mail',
  'ftp',
  'null',
  'undefined',
  'guest',
  'anonymous',
  'noreply',
  'no-reply',
};

/// Same idea as logins; keep separate lists so product can diverge later.
const Set<String> kReservedUsernames = {
  ...kReservedLogins,
  'everyone',
  'here',
  'channel',
  'discord',
};

/// Mailbox local-part atoms that must not receive app accounts (lowercase).
const Set<String> kBlockedEmailLocalParts = {
  'postmaster',
  'webmaster',
  'hostmaster',
  'abuse',
  'noc',
  'security',
  'admin',
  'administrator',
  'root',
  'noreply',
  'no-reply',
  'mailer-daemon',
};

/// Disposable / throwaway domains (lowercase punycode or ASCII labels).
const Set<String> kBlockedEmailDomains = {
  'mailinator.com',
  'guerrillamail.com',
  'tempmail.com',
  '10minutemail.com',
};

/// Explicit full-address denials (`local@domain`, lowercase).
const Set<String> kBlockedFullEmails = <String>{};

/// Display names that impersonate roles or the product (normalized, see policy).
const Set<String> kReservedDisplayNames = {
  'admin',
  'administrator',
  'moderator',
  'mod',
  'system',
  'void',
  'void team',
  'official',
  'staff',
  'support',
  'help desk',
};
