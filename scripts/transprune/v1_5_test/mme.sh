#!/bin/bash

export CUDA_VISIBLE_DEVICES=2
    # --pruning_layer_list  '[7,9,12]' \
    # --image_token_ratio_list "[0.875,0.625,0.125]" \

python llava/eval/model_vqa_loader.py \
    --model-path /home/usr/liao/models/llava-v1.5-7b \
    --question-file /home/usr/liao/datasets/MLLM/eval/MME/llava_mme.jsonl \
    --image-folder /home/usr/liao/datasets/MLLM/eval/MME/MME_Benchmark_release_version \
    --answers-file /home/usr/liao/datasets/MLLM/eval/MME/answers/llava-v1.5-7b.jsonl \
    --temperature 0 \
    --method transprune \
    --accmulating_layer_list  '[7,8,9,10,11,12]' \
    --pruning_layer_list  '[7,9,12]' \
    --image_token_ratio_list "[0.875,0.625,0.125]" \
    --conv-mode vicuna_v1

cd /home/usr/liao/datasets/MLLM/eval/MME

python convert_answer_to_mme.py --experiment llava-v1.5-7b

cd eval_tool

python calculation.py --results_dir answers/llava-v1.5-7b
