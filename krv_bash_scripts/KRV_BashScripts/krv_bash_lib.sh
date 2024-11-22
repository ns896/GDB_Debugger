#!/bin/bash

# Define color codes
GREEN='\033[0;32m'  # Green for Info
YELLOW='\033[0;33m' # Yellow for Warning
RED='\033[0;31m'    # Red for Error
NC='\033[0m'        # No Color (reset)

# Logging function
log_message() {
    local type=$1
    local message=$2

    case "$type" in
        info)
            echo -e "${GREEN}[INFO] $message${NC}"
            ;;
        warn)
            echo -e "${YELLOW}[WARNING] $message${NC}"
            ;;
        error)
            echo -e "${RED}[ERROR] $message${NC}"
            ;;
        *)
            echo -e "[UNKNOWN] $message"  # Handle unexpected types
            ;;
    esac
}

# Function to print a nicely formatted welcome message
KRV_Welcome() {
      
    echo -e "${YELLOW}~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
    echo -e "${YELLOW}~~~~~~~~JAI_GURU_DEV~~~~~~~~${NC}"
    echo -e "${YELLOW}~~~~~~~Navneet Singh~~~~~~~~${NC}"
    echo -e "${YELLOW}~~~~Date: $(date +'%Y-%m-%d')~~~~~~~~${NC}"
    echo -e "${YELLOW}~~~~Time: $(date +'%H:%M:%S')~~~~~~~~~~${NC}"
    echo -e "${YELLOW}~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"

}


#Function to enable file logging
KRV_FileLog_Enable() {
    # Log file path
    LOG_FILE="./krv_script_log.log"

    # Check if log file exists
    if [ -f "$LOG_FILE" ]; then
        log_message "info" "Log file exists. Will append to the log."
    else
        log_message "info" "Creating new log file."
        touch "$LOG_FILE"  # Create the log file
    fi

    # Redirect stdout and stderr to the log file and terminal
    exec > >(tee -a "$LOG_FILE") 2>&1
}
