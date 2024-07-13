{ lib
, fetchFromGitHub
, buildHomeAssistantComponent
, music-assistant
}:

buildHomeAssistantComponent rec {
  owner = "music-assistant";
  domain = "hass_music_assitant";
  version = "2024.6.2";

  src = fetchFromGitHub {
    owner = "music-assistant";
    repo = "hass-music-assistant";
    rev = "refs/tags/${version}";
    hash = "";
  };

  propagatedBuildInputs = [
    music-assistant
  ];

  #skip phases with nothing to do
  # dontConfigure = true;
  # dontBuild = true;
  # doCheck = false;

  meta = with lib; {
    changelog = "https://github.com/music-assistant/hass-music-assistant/releases/tag/${version}";
    description = "Custom integration for Moonraker and Klipper in Home Assistant";
    homepage = "https://github.com/music-assistant/hass-music-assistant";
    maintainers = with maintainers; [ mindstorms6 ];
    license = licenses.asl20;
  };
}
