#!/bin/bash

path=/opt/zimbra/bin
#exeption
haric_kullanici="user@domain.com|user2@domain.om"
sil () {
    local kullanici="$1"
    local tarih=$(date --date="$2 days ago" +%m/%d/%y)
    local satir=0
    local tumSatirlar=0
    local kimden="from1|from2"
    local konu="subject|subject2|subject3"

    rm -f ./eskiMesajlar.txt
    while true; do
        satir=0
        touch ./eskiMesajlar.txt
        echo "$kullanici kullanicisi icin $tarih oncesi arastiriliyor"

        tum_mail_id=$($path/zmmailbox -z -m "$kullanici" search -l 999 " (before:$tarih)" | grep -iE "$kimden" | grep -iE "$konu" | sed -e 's/^[ \t]*//'  | tr -s ' ' | cut -d ' ' -f 2 | grep -E "^-" | tr -d "-" | grep -Ev "^$")
        
        if [[ -z "$tum_mail_id" ]]; then
            satir=0
        else
            satir=$(echo "$tum_mail_id" | wc -l)
        fi
        
        echo "$satir adet silinecek mail tespit edildi"

        if [ $satir -gt 0 ]; then
            for mail_id in $tum_mail_id; do
                if [[ ! -z "$mail_id" ]]; then
                    echo "Mesaj Silindi ID: $mail_id" >> ./eskiMesajlar.txt
                    $path/zmmailbox -z -m "$kullanici" dm "$mail_id"
                fi
            done

            tumSatirlar=$(( tumSatirlar + satir ))
        else
            break
        fi
    done
    echo $tumSatirlar
}

for hesap in $($path/zmprov -l gaa domain.com | grep -ivE $haric_kullanici); do
    echo "$hesap hesabi icin islemler baslatildi"
    satir_sayi=$(sil "$hesap" "15")
    echo "$hesap kullanicisi icin $satir_sayi adet mail silindi"
done
exit
