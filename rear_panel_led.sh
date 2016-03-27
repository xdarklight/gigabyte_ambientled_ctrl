#!/bin/sh

GPIO_BANK8_PIN0_DIR="/sys/class/gpio/it87_gp80"

case "${1}" in
	"on" | "1" | "true")
		VALUE=1
		MESSAGE="Turning rear panel LED on..."
		;;
	"off" | "0" | "false")
		VALUE=0
		MESSAGE="Turning rear panel LED off..."
		;;
	*)
		echo "Usage: ${0} [on/1/true OR off/0/false]"
		exit 1
		;;
esac

if [ ! -e "${GPIO_BANK8_PIN0_DIR}" ]
then
	echo 504 > /sys/class/gpio/export
fi

echo "${MESSAGE}"

echo "out" > "${GPIO_BANK8_PIN0_DIR}/direction"
echo "${VALUE}" > "${GPIO_BANK8_PIN0_DIR}/value"
