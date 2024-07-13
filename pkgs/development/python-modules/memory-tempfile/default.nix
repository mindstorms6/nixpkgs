{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  poetry-core,
  pythonOlder,
  # tests
  pytestCheckHook,
  pytest-benchmark
}:

buildPythonPackage rec {
  pname = "memory-tempfile";
  version = "2.2.3";
  pyproject = true;

  disabled = pythonOlder "3.6";

  src = fetchFromGitHub {
    owner = "mbello";
    repo = "memory-tempfile";
    rev = "refs/tags/v${version}";
    hash = "sha256-4fz2CLkZdy2e1GwGw/afG54LkUVJ4cza70jcbX3rVlQ=";
  };

  postPatch = ''
    substituteInPlace pyproject.toml \
    --replace poetry.masonry.api poetry.core.masonry.api \
    --replace "poetry>=" "poetry-core>="
  '';

  nativeBuildInputs = [
    poetry-core
  ];

  nativeCheckInputs = [
    pytestCheckHook
    pytest-benchmark
  ];

  pythonImportsCheck = [ "memory_tempfile" ];

  meta = with lib; {
    description = "Helper functions to identify and use paths on the OS (Linux-only for now) where RAM-based tempfiles can be created.";
    license = licenses.mit;
    homepage = "https://github.com/mbello/memory-tempfile";
  };
}
