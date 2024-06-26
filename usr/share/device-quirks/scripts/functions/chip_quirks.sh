#!/bin/bash

process_chip_quirks() {

    for script in "$DQ_PATH/scripts/chips/scripts.d/"*".sh"; do
        if [[ -f "$script" ]]; then
            source "$script"

            check_for_device_entry "$(device_quirk_id)"
            if [[ $? -eq 0 ]]; then
                get_firmware_override_status
                ## Quirk fixes allowed
                if [ $? -eq 1 ]; then
                    get_quirk_id_status "$(device_quirk_id)"
                    if [ $? -eq 1 ]; then
                        device_quirk_install
                        if [[ $? -eq 0 ]]; then
                            set_quirk_id_status "$(device_quirk_id)"
                            echo "Quirk fix: $(device_quirk_name) has been applied, DQ_$(device_quirk_id) has been added to your device-quirks.conf"
                        elif [[ $? -eq 2 ]]; then
                            echo "Quirk fix: $(device_quirk_name) already installed."
                        else
                            echo "Quirk fix: $(device_quirk_name) has failed to install."
                        fi
                    else
                        device_quirk_removal
                        if [[ $? -eq 0 ]]; then
                            echo "Quirk fix: $(device_quirk_name) has been removed."
                        elif [[ $? -eq 2 ]]; then
                            echo "Quirk fix: $(device_quirk_name) is not installed."
                        else
                            echo "Quirk fix: $(device_quirk_name) has failed to install."
                        fi
                    fi
                else
                    device_quirk_removal
                    if [[ $? -eq 0 ]]; then
                        echo "Quirk fix: $(device_quirk_name) has been removed."
                    elif [[ $? -eq 2 ]]; then
                        echo "Quirk fix: $(device_quirk_name) is not installed."
                    else
                        echo "Quirk fix: $(device_quirk_name) has failed to install."
                    fi
                fi
            fi
        fi
    done

}