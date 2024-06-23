#!/bin/bash

# Define the DATASETS, SHOTS, CLASSES, and VISA_CLASSES arrays
DATASETS=('mvtec' 'visa')
SHOTS=(1 2 4)
MVTEC_CLASSES=('pill' 'carpet' 'grid' 'leather' 'tile' 'wood'
               'bottle' 'cable' 'capsule' 'hazelnut' 'metal_nut'
               'screw' 'toothbrush' 'transistor' 'zipper')
VISA_CLASSES=('candle' 'capsules' 'cashew' 'chewinggum'
              'fryum' 'macaroni1' 'macaroni2' 'pcb1' 'pcb2'
              'pcb3' 'pcb4' 'pipe_fryum')
SEED=1

# Function to get the classes based on dataset
get_classes() {
    case "$1" in
        mvtec)
            echo "${MVTEC_CLASSES[@]}"
            ;;
        visa)
            echo "${VISA_CLASSES[@]}"
            ;;
        *)
            echo ""
            ;;
    esac
}

# Loop through each dataset
for DATASET in "${DATASETS[@]}"; do
    # Loop through each shot
    for SHOT in "${SHOTS[@]}"; do
        # Get the appropriate classes for the current dataset
        CLASSES=($(get_classes "$DATASET"))
        # Loop through each class
        for CLS in "${CLASSES[@]}"; do
            # Echo the current SHOT and CLS
            echo "Running with SHOT=$SHOT and CLS=$CLS"
            # Run the Python script with the current dataset, shot, and class
            python train_cls.py --dataset "$DATASET" --k-shot "$SHOT" --class_name "$CLS" --seed "$SEED"
        done
    done
done
