#!/bin/bash

export CUDA_VISIBLE_DEVICES=3

python -m llava.eval.model_vqa_science \
    --model-path /home/usr/liao/models/llava-v1.6-vicuna-7b \
    --question-file /home/usr/liao/datasets/MLLM/eval/scienceqa/llava_test_CQM-A.json \
    --image-folder /home/usr/liao/datasets/MLLM/eval/scienceqa/images/test \
    --answers-file /home/usr/liao/datasets/MLLM/eval/scienceqa/answers/llava-v1.6-7b.jsonl \
    --single-pred-prompt \
    --temperature 0 \
    --method transprune \
    --accmulating_layer_list  '[7,8,9,10,11,12]' \
    --pruning_layer_list  '[7,9,12]' \
    --image_token_ratio_list "[0.875,0.625,0.125]" \
    --conv-mode vicuna_v1

python llava/eval/eval_science_qa.py \
    --base-dir /home/usr/liao/datasets/MLLM/eval/scienceqa \
    --result-file /home/usr/liao/datasets/MLLM/eval/scienceqa/answers/llava-v1.6-7b.jsonl \
    --output-file /home/usr/liao/datasets/MLLM/eval/scienceqa/answers/llava-v1.6-7b_output.jsonl \
    --output-result /home/usr/liao/datasets/MLLM/eval/scienceqa/answers/llava-v1.6-7b_result.json
