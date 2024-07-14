 final: prev: {
    coveragepy-lcov = prev.coveragepy-lcov.overridePythonAttrs (
      old: {
        nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [ final.poetry-core ];
      }
    );
    jstyleson = prev.jstyleson.overridePythonAttrs (
      old: {
        nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [ final.setuptools ];
      }
    );
    types-python-slugify = prev.types-python-slugify.overridePythonAttrs (
      old: {
        nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [ final.setuptools ];
      }
    );
    apprise = prev.apprise.overridePythonAttrs (
      old: {
        nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [ final.babel ];
      }
    );
    mkdocs-get-deps = prev.mkdocs-get-deps.overridePythonAttrs (
      old: {
        nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [ final.hatchling ];
      }
    );
    pydantic-to-typescript = prev.pydantic-to-typescript.overridePythonAttrs (
      old: {
        nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [ final.setuptools ];
      }
    );
    mf2py = prev.mf2py.overridePythonAttrs (
      old: {
        nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [ final.setuptools ];
      }
    );
    pyrdfa3 = prev.pyrdfa3.overridePythonAttrs (
      old: {
        patches = old.patches or [ ] ++ [ ./patches/0001-fix-setup.py.patch ];
      }
    );
    html-text = prev.html-text.overridePythonAttrs (
      old: {
        nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [ final.setuptools ];
      }
    );
  }
