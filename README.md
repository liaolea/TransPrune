# [CVPR 2026] TransPrune: Token Transition Pruning for Efficient Large Vision-Language Model

[![Paper](https://img.shields.io/badge/arXiv-2507.20630-b31b1b.svg)](https://arxiv.org/abs/2507.20630)

## 📢 News
* **[2026-02-23]** 🚀 Source code for TransPrune are now available!
* **[2026-02-21]** 🎉 Our paper has been accepted by **CVPR 2026**!
* **[2025-07-15]** 📄 ArXiv version is released: [2507.20630](https://arxiv.org/abs/2507.20630).

## 🔧 Install

1. Clone this repository
```bash
git clone https://github.com/liaolea/TransPrune.git
cd TransPrune
```

2. Install Package
```Shell
conda create -n transprune python=3.10 -y
conda activate transprune
pip install --upgrade pip  # enable PEP 660 support
pip install -e .
```

## 📊 Evaluation

We provide scripts to evaluate TransPrune on standard Large Vision-Language Model benchmarks. See .scrpts/transprune/

## Cite us
```
@misc{li2025transprunetokentransitionpruning,
      title={TransPrune: Token Transition Pruning for Efficient Large Vision-Language Model}, 
      author={Ao Li and Yuxiang Duan and Jinghui Zhang and Congbo Ma and Yutong Xie and Gustavo Carneiro and Mohammad Yaqub and Hu Wang},
      year={2025},
      eprint={2507.20630},
      archivePrefix={arXiv},
      primaryClass={cs.CV},
      url={https://arxiv.org/abs/2507.20630}, 
}
```
