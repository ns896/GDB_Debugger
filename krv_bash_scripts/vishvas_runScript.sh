#!/bin/bash

# Variables for paths and arguments
RADAR_PROCESSOR_PATH="../RadarProcessor/build/Release/bin/zenrecord"
ANTENNA_PATH="../RadarProcessor/rif/configs/radar/antenna/"
CONTROL_PATH="../RadarProcessor/rif/configs/radar/control/"
INTERFACE_PATH="../RadarProcessor/rif/configs/radar/interface/"
MODE="anechoic_chamber_mode.pt"
VEHICLE="vehicle.pt"
ROOT_PATH="."

GDB_DEBUG_SRC="/home/nsingh/GDB_Debugger/VishvasMagic_GDBdebugger.py"
LOG_DIRC="."

echo "~~~~~~~~~~ Jai Guru Dev ~~~~~~~~~~~"
echo "~~~~~~~~~~ Debug Script ~~~~~~~~~~~"
echo "~~~~~~~~~~ Navneet Singh ~~~~~~~~~~~"

# Check if the user provided an argument
if [ "$#" -eq 0 ]; then
    echo "Please provide an argument: 'zenrecord' or 'another_process'"
    exit 1
fi

# Case statement to decide which command to run based on the argument
case "$1" in
"zenrecord_gdb")
    # Run zenrecord with gdb
    echo "Running the zenrecord in GDB"
    #-x "$GDB_DEBUG_SRC"
    gdb -x "$GDB_DEBUG_SRC" --args "$RADAR_PROCESSOR_PATH" --antenna "$ANTENNA_PATH" --control "$CONTROL_PATH" --interface "$INTERFACE_PATH" --root "$ROOT_PATH" --mode "$MODE" --vehicle "$VEHICLE" -log-dir "$LOG_DIRC" --alsologtostderr
    ;;
"zenrecord")
    # Run zenrecord with gdb
    echo "Running the zenrecord"
    "$RADAR_PROCESSOR_PATH" --antenna "$ANTENNA_PATH" --control "$CONTROL_PATH" --interface "$INTERFACE_PATH" --root "$ROOT_PATH" --mode "$MODE" --vehicle "$VEHICLE" --alsologtostderr -log-dir "$LOG_DIRC"
    ;;
*)
    echo "Invalid argument! Please use 'zenrecord' or 'another_process'."
    ;;
esac
