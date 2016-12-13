#!/bin/bash

. ./gpio_it87.sh

case "${1}" in
	"on" | "1" | "true")
		gpio_it87_set_output_value 8 0 1
		echo "Turning rear panel LED on..."
		;;
	"off" | "0" | "false")
		gpio_it87_set_output_value 8 0 0
		echo "Turning rear panel LED off..."
		;;
	*)
		echo "Usage: ${0} [on/1/true OR off/0/false]"
		exit 1
		;;
esac
