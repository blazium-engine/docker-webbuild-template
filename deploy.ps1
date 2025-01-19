docker build -t hangman-game .
docker tag hangman-game registry.digitalocean.com/blazium-registry/hangman-game:latest
docker push registry.digitalocean.com/blazium-registry/hangman-game:latest