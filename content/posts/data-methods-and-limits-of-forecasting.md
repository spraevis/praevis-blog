---
title: "Data, Methods, and the Limits of Forecasts"
date: 2025-11-15
tags: ["forecasting", "methods", "data"]
draft: false
---

In forecasting, the key is not the method but the fit between data and the task.  
Every forecast depends on which data we use and what remains after removing noise.

There are three levels.

1. **Raw data.**  
Observations, prices, news.  
Without interpretation — just a stream.

2. **Processing.**  
Smoothing, filters, feature selection.  
An attempt to preserve structure and remove the rest.

3. **Models.**  
From simple heuristics to statistics and ML.  
The model should be simple enough to work,  
and complex enough to reflect probability.

On Polymarket it boils down to one pipeline:  
data → processing → probability.

If the input data are bad, the method will not save you.  
If the data are clean, even a simple model works.

— S. Praevis
