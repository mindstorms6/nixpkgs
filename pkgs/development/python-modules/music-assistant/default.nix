{
  lib,
  aiodns,
  aiofiles,
  aiohttp,
  aioresponses,
  aiorun,
  aiosqlite,
  asyncio-throttle,
  brotli,
  buildPythonPackage,
  certifi,
  colorlog,
  cryptography,
  eyed3,
  faust-cchardet,
  fetchFromGitHub,
  isort,
  mashumaro,
  memory-tempfile,
  music-assistant-frontend,
  mypy,
  orjson,
  pillow,
  pkgs,
  poetry-core,
  pre-commit-hooks,
  pre-commit,
  pylint,
  pytest-aiohttp,
  pytestCheckHook,
  pythonOlder,
  ruff,
  setuptools,  
  shortuuid,
  syrupy,
  tomli,
  unidecode,
  zeroconf
}:

buildPythonPackage rec {
  pname = "music_assistant";
  version = "2.0.7";
  pyproject = true;

  disabled = pythonOlder "3.11";

  src = fetchFromGitHub {
    owner = "music-assistant";
    repo = "server";
    rev = "refs/tags/${version}";
    hash = "sha256-JtdlZ3hH4fRU5TjmMUlrdSSCnLrIGCuSwSSrnLgjYEs=";
  };

  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace-fail "--cov" "" \
      --replace-fail "music-assistant-frontend==" ""

    substituteInPlace music_assistant/server/controllers/webserver.py \
      --replace-fail "from music_assistant_frontend import where as locate_frontend" "" \
      --replace-fail "locate_frontend()" "\"/tmp\""  
  '';

  build-system = [ poetry-core ];

  dependencies = [
    aiodns
    aiofiles
    aiohttp
    aiosqlite
    asyncio-throttle
    brotli
    certifi
    colorlog
    cryptography
    mashumaro
    memory-tempfile
    # music-assistant-frontend
    orjson
    pillow
    shortuuid
    unidecode
    zeroconf
  ];

  nativeBuildInputs = [ 
    setuptools
  ];

  nativeCheckInputs = [
    pytestCheckHook
    pkgs.codespell
    pkgs.ffmpeg
    isort
    mypy
    pre-commit-hooks
    pre-commit
    pylint
    pytest-aiohttp
    syrupy
    tomli
    ruff
  ];

  pythonImportsCheck = [ "music_assistant.server" ];

  meta = with lib; {
    description = "Module for Music Assistant";
    homepage = "https://github.com/music-assistant/server";
    changelog = "https://github.com/music-assistant/server/releases/tag/v${version}";
    license = licenses.asl20;
    maintainers = with maintainers; [ mindstorms6 ];
  };
}
