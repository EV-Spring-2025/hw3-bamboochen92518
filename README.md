[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/SdXSjEmH)
# EV-HW3: PhysGaussian

This homework is based on the recent CVPR 2024 paper [PhysGaussian](https://github.com/XPandora/PhysGaussian/tree/main), which introduces a novel framework that integrates physical constraints into 3D Gaussian representations for modeling generative dynamics.

You are **not required** to implement training from scratch. Instead, your task is to set up the environment as specified in the official repository and run the simulation scripts to observe and analyze the results.


## Getting the Code from the Official PhysGaussian GitHub Repository
Download the official codebase using the following command:
```
git clone https://github.com/XPandora/PhysGaussian.git
```


## Environment Setup
Navigate to the "PhysGaussian" directory and follow the instructions under the "Python Environment" section in the official README to set up the environment.


## Running the Simulation
Follow the "Quick Start" section and execute the simulation scripts as instructed. Make sure to verify your outputs and understand the role of physics constraints in the generated dynamics.


## Homework Instructions
Please complete Part 1–2 as described in the [Google Slides](https://docs.google.com/presentation/d/13JcQC12pI8Wb9ZuaVV400HVZr9eUeZvf7gB7Le8FRV4/edit?usp=sharing).

### How to Run

```bash
sh run.sh
```

All the demo videos are available [here](https://youtu.be/zz1RqYrKuxY).

### Part 1

In part 1, I chose `jelly` and `plasticine` as the materials.

### Part 2

I chose `plasticine` as the material, and the base configuration file is [here](https://chatgpt.com/c/683fabd1-cabc-8003-9479-31c3128207e6).

The ablation study on different parameters is summarized below:

|                      | base value |
| -------------------- | ---------- |
| n_grid               | 50         |
| substep_dt           | 1e-4       |
| grid_v_damping_scale | 0.9999     |
| softening            | 0.1        |

#### n_grid

I set `n_grid = 10, 20, 50`.

The results are:

```
Average PSNR between n=50 and n=10: 38.48 dB
Average PSNR between n=50 and n=20: 39.79 dB
```

**Insight:** A smaller grid (lower resolution) leads to reduced visual fidelity, as shown by lower PSNR values. Increasing `n_grid` improves the simulation accuracy by offering a finer spatial resolution, but it also increases computational cost.

#### substep_dt

I set `substep_dt = 1e-4, 1e-5, 1e-6`.

The results are:

```
Average PSNR between 1e-4 and 1e-5: 39.18 dB
Average PSNR between 1e-4 and 1e-6: 39.59 dB
```

**Insight:** Reducing the substep timestep helps improve numerical stability and simulation smoothness. However, the improvement in visual quality (PSNR) is moderate, so a trade-off with runtime performance should be considered.

#### grid_v_damping_scale

I set `grid_v_damping_scale = 0.9995, 0.9999, 1.1`.

The results are:

```
Average PSNR between 0.9999 and 0.9995: 40.22 dB
Average PSNR between 0.9999 and 1.1: 39.87 dB
```

**Insight:** Lower damping preserves motion energy more realistically, while higher damping (like 1.1) may introduce unnatural behavior or instabilities. A careful balance is needed to avoid excessive damping or instability.

#### softening

I set `softening = 0.1, 0.2, 0.3`.

The results are:

```
Average PSNR between 0.1 and 0.2: 41.95 dB
Average PSNR between 0.1 and 0.3: 41.95 dB
```

**Insight:** Increasing the softening value slightly changes the simulation behavior, but here, PSNR values remain high and stable. This indicates that the model is not overly sensitive to this parameter in the tested range.

### Bonus

The paper notes that most material-related parameters (e.g., softening, damping, substep) are manually defined, which limits generalization to unseen materials.

To automatically infer these parameters for arbitrary target materials, one could design the following framework:

**1. Data Collection:**
 Collect a dataset of video sequences of different materials under known forces and interactions, along with ground-truth physical parameters (if available).

**2. Feature Extraction:**
 Use pretrained visual encoders (e.g., a ResNet or Vision Transformer) to extract temporal and spatial features from the video.

**3. Parameter Regression Network:**
 Train a neural network that maps extracted video features to the simulation parameters (e.g., `n_grid`, `softening`, `damping_scale`, `substep_dt`). This becomes a prediction model:
 `video ➝ inferred physical parameters`.

**4. Simulation Feedback (optional):**
 Use a differentiable physics simulator to validate the predicted parameters by simulating and comparing with real motion. This forms a closed-loop system for fine-tuning parameter prediction with supervision.

**5. Material Embedding (optional):**
 Instead of predicting scalar parameters directly, learn a low-dimensional "material embedding" that encodes physical behavior and is used to condition the simulation.

This approach would allow PhysGaussian to generalize to unseen materials by inferring appropriate simulation settings directly from input video, eliminating the need for manual tuning.


# Reference
```bibtex
@inproceedings{xie2024physgaussian,
    title     = {Physgaussian: Physics-integrated 3d gaussians for generative dynamics},
    author    = {Xie, Tianyi and Zong, Zeshun and Qiu, Yuxing and Li, Xuan and Feng, Yutao and Yang, Yin and Jiang, Chenfanfu},
    booktitle = {Proceedings of the IEEE/CVF Conference on Computer Vision and Pattern Recognition},
    year      = {2024}
}
```
