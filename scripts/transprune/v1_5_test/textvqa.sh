#!/bin/bash

export CUDA_VISIBLE_DEVICES=3

python -m llava.eval.model_vqa_loader \
    --model-path /home/usr/liao/models/llava-v1.5-7b \
    --question-file /home/usr/liao/datasets/MLLM/eval/textvqa/llava_textvqa_val_v051_ocr.jsonl \
    --image-folder /home/usr/liao/datasets/MLLM/eval/textvqa/train_images \
    --answers-file /home/usr/liao/datasets/MLLM/eval/textvqa/answers/llava-v1.5-7b-liao.jsonl \
    --temperature 0 \
    --method transprune \
    --accmulating_layer_list  '[7,8,9,10,11,12]' \
    --pruning_layer_list  '[7,9,12]' \
    --image_token_ratio_list "[0.875,0.625,0.125]" \
    --conv-mode vicuna_v1

python -m llava.eval.eval_textvqa \
    --annotation-file /home/usr/liao/datasets/MLLM/eval/textvqa/TextVQA_0.5.1_val.json \
    --result-file /home/usr/liao/datasets/MLLM/eval/textvqa/answers/llava-v1.5-7b-liao.jsonl
