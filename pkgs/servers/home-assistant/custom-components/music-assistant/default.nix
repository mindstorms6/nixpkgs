{
  lib,
  fetchFromGitHub,
  buildHomeAssistantComponent,
  music-assistant,
}:

buildHomeAssistantComponent rec {
  owner = "music-assistant";
  domain = "mass";
  version = "2024.6.2";

  src = fetchFromGitHub {
    owner = "music-assistant";
    repo = "hass-music-assistant";
    rev = "refs/tags/${version}";
    hash = "sha256-Wvc+vUYkUJmS4U34Sh/sDCVXmQA0AtEqIT8MNXd++3M=";
  };

  dependencies = [ music-assistant ];

  postPatch = ''
    substituteInPlace custom_components/mass/manifest.json --replace-fail 'music-assistant==2.0.6' 'music-assistant'
  '';

  meta = with lib; {
    changelog = "https://github.com/music-assistant/hass-music-assistant/releases/tag/${version}";
    description = "Custom integration for Music Assistant in Home Assistant";
    homepage = "https://github.com/music-assistant/hass-music-assistant";
    maintainers = with maintainers; [ mindstorms6 ];
    license = licenses.asl20;
  };
}
