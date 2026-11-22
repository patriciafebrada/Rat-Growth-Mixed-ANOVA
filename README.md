# Rat-Growth-Mixed-ANOVA

**Student:** Patricia Febrada  
**Course:** BIO2105 – Biostatistics  
**Assessment:** Formative Assessment 11: Mixed-Design Repeated Measures ANOVA Using R  

## Project Overview & Research Objectives

This repository contains a reproducible statistical analysis of the rat growth experiment originally reported by Box (1950) and available in the `nlmm` R package (`rats` dataset). Twenty-seven rats assigned to three drinking-water treatment groups—**Control** ($n = 10$), **Thiouracil** ($n = 10$), and **Thyroxin** ($n = 7$, following the accidental loss of three animals)—were weighed weekly across five measurement occasions from **Week 0 (Baseline)** through **Week 4** ($135$ total observations).

### Research Objectives
1. Determine whether average rat body weight differs significantly across the three treatment groups (between-subjects main effect).
2. Determine whether rat body weight changes significantly across the five weekly measurement occasions (within-subjects main effect).
3. Investigate whether the pattern of body weight change over time differs depending on the treatment received (**Treatment $\times$ Time interaction**) and decompose significant interaction effects using simple main effects and pairwise comparisons.

## Repository Structure

Rat-Growth-Mixed-ANOVA/
├── README.md
├── Rat_Growth_Mixed_ANOVA.R
├── Rat_Growth_Mixed_ANOVA.Rmd
├── Rat_Growth_Mixed_ANOVA.html
└── data/
    └── Rat_Growth_Dataset.csv

## Instructions to Reproduce the Analysis

1. **Clone or download this repository** to your local computer.
2. **Open R or RStudio** (R $\ge$ 4.1.0 recommended).
3. **Install the required packages** (if not already installed):
   ```r
   install.packages(c("nlmm", "tidyverse", "rstatix", "ggpubr", "knitr"))
