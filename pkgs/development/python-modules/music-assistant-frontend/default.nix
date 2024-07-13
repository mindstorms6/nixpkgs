{
  lib,
  buildPythonPackage,
  fetchPypi,
  pkgs,
  pytestCheckHook,
  pythonOlder,
  setuptools,
  wheel
}:

buildPythonPackage rec {
  pname = "music-assistant-frontend";
  version = "2.6.3";
  pyproject = true;  

  disabled = pythonOlder "3.9";

  propagatedBuildInputs = [
    setuptools
    wheel
  ];

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-LLU6uRG8ShY5DcwNSJlAKU48iSfQh7a2f9tjMxMDpT4=";
  };

  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace-fail "setuptools==" "setuptools>=" \
      --replace-fail "wheel==" "wheel>="

    sed -i '/--cov=/d' pyproject.toml
  '';

  pythonImportsCheck = [ "music_assistant_frontend" ];

  meta = with lib; {
    description = "Frontend module for Music Assistant";
    homepage = "https://github.com/music-assistant/frontend";
    changelog = "https://github.com/music-assistant/frontend/releases/tag/v${version}";
    license = licenses.asl20;
    maintainers = with maintainers; [ mindstorms6 ];
  };
}
