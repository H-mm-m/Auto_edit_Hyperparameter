## 1.Installation

Please refer to the environment installation in ``python_env/environment.yml``:

```bash
conda env export -n p2p > python_env/environment.yml
```
记录部分bash过程-``log.txt ``

# 2.DataSets
Put them into the ``data`` folder.

训练数据集 EditBench： [here](https://drive.google.com/file/d/1vI95rLwleXZs_2lUxulI-f06Ngr8XcL1/view?usp=sharing).

测试数据集 PieBench：  [here](https://github.com/cure-lab/PnPInversion). 需要填写表单申请

## 3.Checkpoint

Checkpoint path can be downloaded [here](https://drive.google.com/drive/folders/1uA2EZ2RogMFQFzzIVf2MPusmTKAAwaF0?usp=sharing). 

## 4.Running AutoEdit
**DDPM-Inversion**: Search for inversion timestep:

```bash
python run_training_wo_attention.py \
    --checkpoint "exp/ddpm_ppo/checkpoint.ckpt" \
    --input_image_path "assets/cake.jpg" \
    --src_prompt "a round cake with orange frosting on a wooden plate" \
    --tgt_prompt "a square cake with orange frosting on a wooden plate" \
    --save_edit_path "output/edit_cake.png"
```

**P2P**: Conduct the DDPM Inversion and cross-attention ratio search:

```bash
python run_training.py \
  --checkpoint "exp/ddpm_ppo/checkpoint.ckpt" \
  --input_image_path "assets/cake.jpg" \
  --src_prompt "a round cake with orange frosting on a wooden plate" \
  --tgt_prompt "a square cake with orange frosting on a wooden plate" \
  --save_edit_path "output/edit_cake.png"
```

**Null-text**: Null-text inversion and searching for inversion timestep
```bash
python null_text_inversion.py \
  --checkpoint_path "exp/null_text_ppo/checkpoint.ckpt" \
  --input_image_path "assets/cake.jpg" \
  --src_prompt "a round cake with orange frosting on a wooden plate" \
  --tgt_prompt "a square cake with orange frosting on a wooden plate" \
  --save_edit_path "output/edit_cake.png"
```

**Adaptive CFG**:
```bash
python run_training_cfg.py \
    --checkpoint "exp/cfg_ppo/checkpoint.ckpt" \
    --input_image_path "assets/cake.jpg" \
    --src_prompt "a round cake with orange frosting on a wooden plate" \
    --tgt_prompt "a square cake with orange frosting on a wooden plate" \
    --save_edit_path "output/edit_cake.png"
```

## 5.Training AutoEdit


Training AutoEdit for DDPM inversion:

**Stage 1**:SFT training
```bash
python run_training_wo_attention.py \
    --exp_name "exp/ddpm_ppo_sft" \
    --num_epochs 5 \
    --low 0.05 \
    --range 0.6 \
    --annotation_folder "data/EditBench/EditData" \
    --train_sft
```

**Stage 2**: PPO training
```bash
python run_training_wo_attention.py \
    --exp_name "exp/ddpm_ppo_sft" \
    --num_epochs 15 \
    --annotation_folder "data/EditBench/EditData" \
    --train_ppo \
    --checkpoint "path/to/checkpoint_sft"
```
