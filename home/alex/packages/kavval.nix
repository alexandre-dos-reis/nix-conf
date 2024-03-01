{pkgs, ...}: {
  # https://gist.github.com/ArnaudD/8d526b20a03c6c18a3ba
  home.packages = with pkgs; [
    google-cloud-sdk
    nodejs_18
    ruby
    docker
    docker-compose
    google-chrome
    ngrok
    jq
  ];
}