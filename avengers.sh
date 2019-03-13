#! /bin/bash

echo "Creating docker-compose.yml file with Avengers"

avengers=("iron_man" "captain_america" "thor" "war_machine" "vision" "hawkeye" "hulk" "black_widow" "ant_man" "falcon" "scarlett_witch" "black_panther" "winter_soldier")

if [[ -f docker-compose.yml ]]
then
    rm docker-compose.yml
fi

echo -e "version: '3.7'\n\nservices:" >> docker-compose.yml


for avenger in "${avengers[@]}"
do
    echo -e "  avengers_$avenger:\n    container_name: avengers_$avenger\n    build: .\n" >> docker-compose.yml
done

echo "File generated!"
