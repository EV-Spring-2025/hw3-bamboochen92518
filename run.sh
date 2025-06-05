#!/bin/bash

# Define the list of items
items=('p_n10' 'p_n20' 'p_n50' 'p_sd4' 'p_sd5' 'p_sd6' 'p_g9995' 'p_g9999' 'p_g11' 'p_s01' 'p_s02' 'p_s03')

# Loop through each item in the list
for i in "${items[@]}"
do
    echo "Running simulation for: $i"
    python gs_simulation.py \
        --model_path ./model/ficus_whitebg-trained/ \
        --output_path "output_${i}" \
        --config "./config/config_${i}.json" \
        --render_img \
        --compile_video \
        --white_bg
    if [ $? -eq 0 ]; then
        echo "Successfully completed simulation for: $i"
    else
        echo "Error: Simulation failed for: $i"
    fi
done

echo "All simulations completed."
