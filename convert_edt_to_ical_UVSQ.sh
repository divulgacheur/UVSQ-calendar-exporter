#!/bin/bash

# Variables pour le point d'entrée, les paramètres et la formation
URL='https://edt.uvsq.fr/Home/GetCalendarData'
FORMATION='MYCYB2_88'
DATA="start=2023-09-18&end=2024-09-23&resType=103&calView=agendaWeek&federationIds%5B%5D=$FORMATION&colourScheme=3"

# Fonction pour récupérer les données JSON
fetch_data() {
    curl "$URL" --data-raw "$DATA" -s
}

# Fonction pour convertir les entités HTML
convert_html_entities() {
    echo "$1" | sed -e 's/&amp;/\&/g' \
        -e 's/&lt;/</g' -e 's/&gt;/>/g' \
        -e 's/&quot;/"/g' -e "s/&#39;/'/g" \
        -e "s/&#232;/è/g" -e "s/&#233;/é/g"
}

# Fonction principale pour traiter le JSON et afficher le format iCal
process_data() {
    jq -rc '.[]' | while IFS= read -r event; do
        id=$(echo "$event" | jq -r ".id")
        start=$(echo "$event" | jq -r ".start" | sed 's/-//g' | sed 's/://g')
        end=$(echo "$event" | jq -r ".end" | sed 's/-//g' | sed 's/://g')
        description=$(echo "$event" | jq -r ".description" | sed 's/<br \/>/ /g' | tr -s '\n\r' ' ')

        data=$(convert_html_entities "$description")
        summary=$(echo "$data" | cut -d "]" -f2)
        location=$(echo "$data" | cut -d "[" -f1)

        echo "BEGIN:VEVENT"
        echo "UID:$id"
        echo "DTSTART;TZID=Europe/Paris:$start"
        echo "DTEND;TZID=Europe/Paris:$end"
        echo "SUMMARY:$summary"
        echo "LOCATION:$location"
        echo "DESCRIPTION:Mis à jour le $(date +'%d/%m/%Y %H:%M')"
        echo "END:VEVENT"
    done
}

# Exécution principale
echo "BEGIN:VCALENDAR"
echo "VERSION:2.0"
echo "PRODID:-//EDT M2 IRS Cyber - edit by Théo Peltier//EN"
echo "CALSCALE:GREGORIAN"
echo "METHOD:PUBLISH"

json_data=$(fetch_data)
echo "$json_data" | process_data

echo "END:VCALENDAR"

