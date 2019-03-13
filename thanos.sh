#! /bin/bash

peacefull="Thanos is peacefull."

thanos_kills_avengers(){
    avengers=$(docker ps -a -q --filter="name=avengers_")

    avengers=${avengers} | sort -R

    if [[ -z ${avengers} ]]
    then
        echo "Nobody to kill. "${peacefull} && exit 0
    else
        echo -e "Thanos snaps fingers...\n"
    fi

    has_killed=false

    index=0
    for avenger in ${avengers}
    do
        if(($index % 2 == 0))
        then
            avenger_name=$(docker ps -a --format "{{.Names}}" --filter="id=$avenger")
            avenger_name=${avenger_name//avengers_/}
            avenger_name=${avenger_name//_/ }
            echo "$(tr a-z A-Z <<< ${avenger_name:0:1})${avenger_name:1} disappears!"
            docker stop ${avenger} > /dev/null && docker rm ${avenger} > /dev/null
            has_killed=true
        fi
        index=$(( $index + 1 ))
    done

    if [[ ${has_killed} == false ]]
    then
        echo "Thanos did not kill anyone. "${peacefull}
    else
        echo -e "\n"${peacefull}
    fi
}

thanos_do_something(){

    actions=("smiles" "laughs" "waits" "sleeps" "yawns")

    echo -e "\nThanos ${actions[$(( ( RANDOM % ${#actions[@]} ) ))]}.\n    (use './thanos.sh snap-fingers --with-glove' to kill Avengers)\n"
}

if [[ ! $1 == "snap-fingers" || ! $2 == "--with-glove" ]]
then
    thanos_do_something
    exit 0
else
    thanos_kills_avengers
fi


