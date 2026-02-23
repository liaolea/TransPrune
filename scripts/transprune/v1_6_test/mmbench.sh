#!/bin/bash

export CUDA_VISIBLE_DEVICES=0

SPLIT="mmbench_dev_20230712"

python -m llava.eval.model_vqa_mmbench \
    --model-path /home/usr/liao/models/llava-v1.6-vicuna-7b \
    --question-file /home/usr/liao/datasets/MLLM/eval/mmbench/$SPLIT.tsv \
    --answers-file /home/usr/liao/datasets/MLLM/eval/mmbench/answers/$SPLIT/llava-v1.6-7b.jsonl \
    --single-pred-prompt \
    --temperature 0 \
    --conv-mode vicuna_v1 \
    --method transprune \
    --accmulating_layer_list  '[7,8,9,10,11,12]' \
    --pruning_layer_list  '[7,9,12]' \
    --image_token_ratio_list "[0.875,0.625,0.125]" \

mkdir -p /home/usr/liao/datasets/MLLM/eval/mmbench/answers_upload/$SPLIT

python scripts/convert_mmbench_for_submission.py \
    --annotation-file /home/usr/liao/datasets/MLLM/eval/mmbench/$SPLIT.tsv \
    --result-dir /home/usr/liao/datasets/MLLM/eval/mmbench/answers/$SPLIT \
    --upload-dir /home/usr/liao/datasets/MLLM/eval/mmbench/answers_upload/$SPLIT \
    --experiment llava-v1.6-7b
