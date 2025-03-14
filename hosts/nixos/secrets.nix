{
  age = {
    identityPaths = ["/home/keynold/.ssh/id_ed25519"];
    secrets = {
      github-nqp = {
        file = ../../secrets/github-nqp.age;
        owner = "keynold";
        mode = "0400";
      };
      password-keynold = {
        file = ../../secrets/password-keynold.age;
        owner = "keynold";
      };
      CODESTRAL_API_KEY = {
        file = ../../secrets/CODESTRAL_API_KEY.age;
        owner = "keynold";
      };
      OPENAI_API_KEY = {
        file = ../../secrets/OPENAI_API_KEY.age;
        owner = "keynold";
      };
      GEMINI_API_KEY = {
        file = ../../secrets/GEMINI_API_KEY.age;
        owner = "keynold";
      };
      #   gitlab-nqp = {
      #     file = ../../secrets/gitlab-nqp.age;
      #     owner = "keynold";
      #     mode = "0400";
      #   };
    };
  };
}
