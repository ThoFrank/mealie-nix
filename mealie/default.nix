{ src
, mkPoetryApplication
, python
, overrides
, lib
}:
mkPoetryApplication {
  projectDir = src;
  python = python;
  overrides = overrides.withDefaults (import ./overrides.nix);
  meta = {
    description = "Self hosted recipe manager and meal planner";
    longDescription = ''
      Mealie is a self hosted recipe manager and meal planner with a REST API and a reactive frontend
      application built in NuxtJS for a pleasant user experience for the whole family. Easily add recipes into your
      database by providing the URL and Mealie will automatically import the relevant data or add a family recipe with
      the UI editor.
    '';
    homepage = "https://mealie.io";
    changelog = "https://github.com/mealie-recipes/mealie/releases/tag/${src.rev}";
    license = lib.licenses.agpl3Only;
    mainProgram = "start";
  };
}
