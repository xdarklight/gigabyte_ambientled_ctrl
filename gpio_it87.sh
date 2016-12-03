#!/bin/sh

gpio_it87_set_output_value() {
	local GPIO_BANK_NUM=${1}
	local GPIO_BANK_PIN=${2}
	local GPIO_VALUE=${3}
	local GPIO_PIN_DIR="/sys/class/gpio/it87_gp${GPIO_BANK_NUM}${GPIO_BANK_PIN}"
	local IT87_GPIO_BASE=448
	local GLOBAL_GPIO_NUM=$(( IT87_GPIO_BASE + ((GPIO_BANK_NUM - 1) * 8) + $GPIO_BANK_PIN ))

	if [ ! -e "${GPIO_PIN_DIR}" ]
	then
		echo "${GLOBAL_GPIO_NUM}" > /sys/class/gpio/export
	fi

	echo "out" > "${GPIO_PIN_DIR}/direction"
	echo "${GPIO_VALUE}" > "${GPIO_PIN_DIR}/value"
}
