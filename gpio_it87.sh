#!/bin/sh

gpio_it87_get_base() {
	local IT87_GPIO_LABEL_FILE=$(grep -l "gpio_it87" /sys/class/gpio/gpiochip*/label)

	if [ -z "${IT87_GPIO_LABEL_FILE}" ]
	then
		echo "could not find gpio_it87 GPIO entry"
		echo "make sure the gpio_it87 driver is supported by your kernel and loaded"
		exit 1
	fi

	cat "$(dirname "${IT87_GPIO_LABEL_FILE}")/base"
}

gpio_it87_set_output_value() {
	local GPIO_BANK_NUM=${1}
	local GPIO_BANK_PIN=${2}
	local GPIO_VALUE=${3}
	local GPIO_PIN_DIR="/sys/class/gpio/it87_gp${GPIO_BANK_NUM}${GPIO_BANK_PIN}"
	local IT87_GPIO_BASE=$(gpio_it87_get_base)
	local GLOBAL_GPIO_NUM=$(( IT87_GPIO_BASE + ((GPIO_BANK_NUM - 1) * 8) + $GPIO_BANK_PIN ))

	if [ ! -e "${GPIO_PIN_DIR}" ]
	then
		echo "${GLOBAL_GPIO_NUM}" > /sys/class/gpio/export
	fi

	echo "out" > "${GPIO_PIN_DIR}/direction"
	echo "${GPIO_VALUE}" > "${GPIO_PIN_DIR}/value"
}
