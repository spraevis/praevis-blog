---
title: "Predictors, Time Series, and Model Choice"
date: 2025-11-15
tags: ["forecasting", "models", "methods"]
draft: false
---

In forecasting, there are three types of models.

1. **Models with predictors.**  
They use external variables — temperature, the economy, human behavior.  
These models explain *why* something happens.

2. **Time‑series models.**  
They look only at the past values of the series.  
They explain nothing, but often predict better.

3. **Hybrid models.**  
A combination of past dynamics and external factors.

Why is it sometimes better to use only a time series?  
Because external variables may be unknown,  
hard to measure, or unpredictable themselves.  
Sometimes the goal is simply to predict, not to explain.

This is especially visible on Polymarket:  
if predictors are unavailable or unreliable,  
a simple dynamics model often works better.

The model is chosen by data, resources, and purpose —  
not by elegance.

— S. Praevis
