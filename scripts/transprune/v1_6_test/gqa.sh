#!/bin/bash

gpu_list="${CUDA_VISIBLE_DEVICES:-1}"
IFS=',' read -ra GPULIST <<< "$gpu_list"

CHUNKS=${#GPULIST[@]}

CKPT="llava-v1.6-7b"
SPLIT="llava_gqa_testdev_balanced"
GQADIR="/home/usr/liao/datasets/MLLM/eval/gqa/data"

for IDX in $(seq 0 $((CHUNKS-1))); do
    CUDA_VISIBLE_DEVICES=${GPULIST[$IDX]} python -m llava.eval.model_vqa_loader \
        --model-path /home/usr/liao/models/llava-v1.6-vicuna-7b \
        --question-file /home/usr/liao/datasets/MLLM/eval/gqa/$SPLIT.jsonl \
        --image-folder /home/usr/liao/datasets/MLLM/eval/gqa/data/images \
        --answers-file /home/usr/liao/datasets/MLLM/eval/gqa/answers/$SPLIT/$CKPT/${CHUNKS}_${IDX}.jsonl \
        --num-chunks $CHUNKS \
        --chunk-idx $IDX \
        --temperature 0 \
        --method transprune \
        --accmulating_layer_list  '[7,8,9,10,11,12]' \
        --pruning_layer_list  '[7,9,12]' \
        --image_token_ratio_list "[0.875,0.625,0.125]" \
        --conv-mode vicuna_v1 &
done

wait

output_file=/home/usr/liao/datasets/MLLM/eval/gqa/answers/$SPLIT/$CKPT/merge.jsonl

# Clear out the output file if it exists.
> "$output_file"

# Loop through the indices and concatenate each file.
for IDX in $(seq 0 $((CHUNKS-1))); do
    cat /home/usr/liao/datasets/MLLM/eval/gqa/answers/$SPLIT/$CKPT/${CHUNKS}_${IDX}.jsonl >> "$output_file"
done

python scripts/convert_gqa_for_eval.py --src $output_file --dst $GQADIR/testdev_balanced_predictions.json

cd $GQADIR
python eval/eval.py --tier testdev_balanced
