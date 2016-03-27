#!/bin/sh

GPIO_BANK8_PIN2_DIR="/sys/class/gpio/it87_gp82"
GPIO_BANK8_PIN3_DIR="/sys/class/gpio/it87_gp83"

case "${1,,}" in
	"alwaysoff" | "off")
		GPIO_BANK8_PIN2_VALUE=0
		GPIO_BANK8_PIN3_VALUE=0
		MESSAGE="Turning audio LED off..."
		;;
	"alwayson" | "on")
		GPIO_BANK8_PIN2_VALUE=0
		GPIO_BANK8_PIN3_VALUE=1
		MESSAGE="Enabling still mode for audio LED..."
		;;
	"beatmode" | "beat" | "tempomode" | "tempo")
		GPIO_BANK8_PIN2_VALUE=1
		GPIO_BANK8_PIN3_VALUE=1
		MESSAGE="Enabling beat/tempo mode for audio LED..."
		;;
	"pulsemode" | "pulse" | "breathmode" | "breath")
		GPIO_BANK8_PIN2_VALUE=0
		GPIO_BANK8_PIN3_VALUE=1
		echo "Breath/Pulse mode is not implemented yet (gpio-it87 does not support SuperIO register 251 yet)"
		exit 1
		;;
	*)
		echo "Usage: ${0} [AlwaysOn/AlwaysOff/BeatMode/PulseMode]"
		exit 1
		;;
esac

if [ ! -e "${GPIO_BANK8_PIN2_DIR}" ]
then
	echo 506 > /sys/class/gpio/export
fi

if [ ! -e "${GPIO_BANK8_PIN3_DIR}" ]
then
	echo 507 > /sys/class/gpio/export
fi

echo "${MESSAGE}"

echo "out" > "${GPIO_BANK8_PIN2_DIR}/direction"
echo "${GPIO_BANK8_PIN2_VALUE}" > "${GPIO_BANK8_PIN2_DIR}/value"

echo "out" > "${GPIO_BANK8_PIN3_DIR}/direction"
echo "${GPIO_BANK8_PIN3_VALUE}" > "${GPIO_BANK8_PIN3_DIR}/value"
