python /home/hemiao/AutoEdit/AutoEdit-main/run_training_wo_attention.py \
    --checkpoint "/home/hemiao/AutoEdit/AutoEdit-main/model-weight/ddpm_ppo/checkpoint.ckpt" \
    --input_image_path "/home/hemiao/AutoEdit/AutoEdit-main/assets/cake.jpg" \
    --src_prompt "a round cake with orange frosting on a wooden plate" \
    --tgt_prompt "a square cake with orange frosting on a wooden plate" \
    --save_edit_path "/home/hemiao/AutoEdit/AutoEdit-main/output/edit_cake.png"
    #--checkpoint "exp/ddpm_ppo/checkpoint.ckpt" \