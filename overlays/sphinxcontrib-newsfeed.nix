final: prev: {
  sphinxcontrib-newsfeed = prev.sphinxcontrib-newsfeed.overrideAttrs (old: {
    pyproject = true;
    nativeBuildInputs = [prev.setuptools];
    propagatedBuildInputs = [prev.sphinx];
    meta.homepage = "https://github.com/prometheusresearch/sphinxcontrib-newsfeed";
  });
}