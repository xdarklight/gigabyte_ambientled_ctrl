#!/bin/bash

. ./gpio_it87.sh

SCRIPT_NAME="${0}"

config_simple_audio_led_board() {
	local SELECTED_MODE="${1}"

	case "${SELECTED_MODE,,}" in
		"alwaysoff" | "off")
			gpio_it87_set_output_value 2 6 0
			echo "Turning audio LED off..."
			;;
		"alwayson" | "on")
			gpio_it87_set_output_value 2 6 1
			echo "Turning audio LED on..."
			;;
		*)
			echo "Usage: ${SCRIPT_NAME} [AlwaysOn/AlwaysOff]"
			exit 1
			;;
	esac
}

config_advanced_audio_led_board() {
	local SELECTED_MODE="${1}"

	case "${SELECTED_MODE,,}" in
		"alwaysoff" | "off")
			gpio_it87_set_output_value 8 2 0
			gpio_it87_set_output_value 8 3 0
			echo "Turning audio LED off..."
			;;
		"alwayson" | "on")
			gpio_it87_set_output_value 8 2 0
			gpio_it87_set_output_value 8 3 1
			echo "Enabling still mode for audio LED..."
			;;
		"beatmode" | "beat" | "tempomode" | "tempo")
			gpio_it87_set_output_value 8 2 1
			gpio_it87_set_output_value 8 3 1
			echo "Enabling beat/tempo mode for audio LED..."
			;;
		"pulsemode" | "pulse" | "breathmode" | "breath")
			gpio_it87_set_output_value 8 2 0
			gpio_it87_set_output_value 8 3 1
			echo "Breath/Pulse mode is not implemented yet (gpio-it87 does not support SuperIO register 251 yet)"
			exit 1
			;;
		*)
			echo "Usage: ${SCRIPT_NAME} [AlwaysOn/AlwaysOff/BeatMode/PulseMode]"
			exit 1
			;;
	esac
}

BOARD_NAME="$(cat /sys/class/dmi/id/board_name)"

case "${BOARD_NAME}" in
	"H170M-D3H")
		config_simple_audio_led_board "${1}"
		;;
	"H170-Gaming 3" |\
	"Z170X-Gaming 7" |\
	"Z170X-UD5 TH-CF")
		config_advanced_audio_led_board "${1}"
		;;
	*)
		echo "Unuspported board: \"${BOARD_NAME}\"!"
		exit 1
		;;
esac
