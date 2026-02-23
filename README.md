# [CVPR 2026] TransPrune: Token Transition Pruning for Efficient Large Vision-Language Model

[![Paper](https://img.shields.io/badge/arXiv-2507.20630-b31b1b.svg)](https://arxiv.org/abs/2507.20630)

## 📢 News
* **[2026-02-23]** 🚀 Source code for TransPrune are now available!
* **[2026-02-21]** 🎉 Our paper has been accepted by **CVPR 2026**!
* **[2025-07-15]** 📄 ArXiv version is released: [2507.20630](https://arxiv.org/abs/2507.20630).


## 🔧 Install

1. Clone this repository
```bash
git clone https://github.com/Cooperx521/PyramidDrop.git
cd TransPrune
```

2. Install Package
```Shell
conda create -n pdrop python=3.10 -y
conda activate pdrop
pip install --upgrade pip  # enable PEP 660 support
pip install -e .
```

3. Install additional packages for training
```
pip install -e ".[train]"
pip install flash-attn --no-build-isolation
```
