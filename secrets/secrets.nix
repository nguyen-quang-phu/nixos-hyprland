let
  keynold = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO5DdRjRbHb8R2ztfztTTxkF3zOl9HsQJW/F93BMV8Pf keynold@nixos";
  users = [keynold];

  system1 = "";
  systems = [system1];
in {
  "github-nqp.age".publicKeys = [keynold];
  "gitlab-nqp.age".publicKeys = [keynold];
  "password-keynold.age".publicKeys = [keynold];
  "CODESTRAL_API_KEY.age".publicKeys = [keynold];
  "OPENAI_API_KEY.age".publicKeys = [keynold];
  "GEMINI_API_KEY.age".publicKeys = [keynold];
}
