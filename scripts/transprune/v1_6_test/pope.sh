#!/bin/bash

export CUDA_VISIBLE_DEVICES=3

python llava/eval/model_vqa_loader.py \
    --model-path /home/usr/liao/models/llava-v1.6-vicuna-7b \
    --question-file /home/usr/liao/datasets/MLLM/eval/pope/llava_pope_test.jsonl \
    --image-folder /home/usr/liao/datasets/MLLM/eval/pope/val2014 \
    --answers-file /home/usr/liao/datasets/MLLM/eval/pope/answers/llava-v1.6-7b.jsonl \
    --temperature 0 \
    --method transprune \
    --accmulating_layer_list  '[7,8,9,10,11,12]' \
    --pruning_layer_list  '[7,9,12]' \
    --image_token_ratio_list "[0.875,0.625,0.125]" \
    --conv-mode vicuna_v1

python llava/eval/eval_pope.py \
    --annotation-dir /home/usr/liao/datasets/MLLM/eval/pope/coco \
    --question-file /home/usr/liao/datasets/MLLM/eval/pope/llava_pope_test.jsonl \
    --result-file /home/usr/liao/datasets/MLLM/eval/pope/answers/llava-v1.6-7b.jsonl
