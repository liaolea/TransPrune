#!/bin/bash

gpu_list="${CUDA_VISIBLE_DEVICES:-0}"
IFS=',' read -ra GPULIST <<< "$gpu_list"

CHUNKS=${#GPULIST[@]}

CKPT="llava-v1.5-7b"

for IDX in $(seq 0 $((CHUNKS-1))); do
    CUDA_VISIBLE_DEVICES=${GPULIST[$IDX]} python -m llava.eval.model_vqa_loader \
        --model-path /home/usr/liao/models/llava-v1.5-7b \
        --question-file /home/usr/liao/datasets/MLLM/eval/seed_bench/llava-seed-bench.jsonl \
        --image-folder /home/usr/liao/datasets/MLLM/eval/seed_bench \
        --answers-file /home/usr/liao/datasets/MLLM/eval/seed_bench/answers/$CKPT/${CHUNKS}_${IDX}.jsonl \
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

output_file=/home/usr/liao/datasets/MLLM/eval/seed_bench/answers/$CKPT/merge.jsonl

# Clear out the output file if it exists.
> "$output_file"

# Loop through the indices and concatenate each file.
for IDX in $(seq 0 $((CHUNKS-1))); do
    cat /home/usr/liao/datasets/MLLM/eval/seed_bench/answers/$CKPT/${CHUNKS}_${IDX}.jsonl >> "$output_file"
done

# Evaluate
python scripts/convert_seed_for_submission.py \
    --annotation-file /home/usr/liao/datasets/MLLM/eval/seed_bench/SEED-Bench.json \
    --result-file $output_file \
    --result-upload-file /home/usr/liao/datasets/MLLM/eval/seed_bench/answers_upload/llava-v1.5-7b.jsonl

