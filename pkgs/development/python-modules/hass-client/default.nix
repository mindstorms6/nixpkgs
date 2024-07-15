{
  aiohttp,
  buildPythonPackage,
  lib,
  fetchPypi,
  pytestCheckHook,
  setuptools,
  pytest-asyncio,
}:

buildPythonPackage rec {
  pname = "hass-client";
  version = "1.2.0";
  pyproject = true;

  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace-fail "--cov" ""
  '';

  src = fetchPypi {
    inherit version;
    pname = "hass_client";
    hash = "sha256-x6i6OrfO3fUG+erdgI07SqNOuwXIlQmuzW2qQi8e6RY=";
  };

  build-system = [ setuptools ];

  # Pypi package has no tests to run
  doCheck = false;

  pythonImportsCheck = [ "hass_client" ];

  dependencies = [ aiohttp ];

  meta = with lib; {
    description = "Very basic client for connecting to Home Assistant over websockets and REST.";
    homepage = "https://pypi.org/project/hass-client/#description";
    license = licenses.asl20;
    maintainers = with maintainers; [ mindstorms6 ];
  };
}
