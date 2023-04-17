#!/bin/bash

export PYTHONUNBUFFERED="True"

NUM_GPUS=$1
DATASET=$2
SHARE=$3
TAG=$4

array=( $@ )
len=${#array[@]}
EXTRA_ARGS=${array[@]:4:$len}

SCHEDULE="30 60 80"
GAMMA="0.2 0.2 0.2"
DECAY=1e-4
EPOCHS=90
BATCH_SIZE=256


case ${DATASET} in
    imagenet)
            python main.py /projectnb/ivc-ml/dbash/data/imagenet/ILSVRC/Data/CLS-LOC/ /projectnb/ivc-ml/piotrt/data/imagenet   --dataset ${DATASET} \
            --wide 1 \
            --share_type ${SHARE} --job-id ${TAG} \
            --epochs ${EPOCHS} --batch_size ${BATCH_SIZE} \
            --decay ${DECAY} --schedule ${SCHEDULE} \
            --gammas ${GAMMA} --ngpu ${NUM_GPUS} \
            --arch wrn_imagenet --warmup_epochs 10 --label_smoothing 0.1 \
            ${EXTRA_ARGS}
        ;;
    rand_imagenet)
            ipython -i  main.py --  data --dataset ${DATASET} \
            --depth ${DEPTH} --wide 1 \
            --share_type ${SHARE} --job-id ${TAG} \
            --epochs ${EPOCHS} --batch_size ${BATCH_SIZE} \
            --decay ${DECAY} --schedule ${SCHEDULE} \
            --gammas ${GAMMA} --ngpu ${NUM_GPUS} \
            ${EXTRA_ARGS}
        ;;
    *)
        echo "No dataset given"
        exit
        ;;
esac

