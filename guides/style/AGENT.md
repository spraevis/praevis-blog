# AGENT.md — S. Praevis Content Agents

Purpose: single entrypoint for all agents. Always follow this file first.

## Minimal Load Order (token‑efficient)
1) Read TLDR: ./TLDR.md
2) Load machine index: ./INDEX.json
3) Select sections by task:
   - blog_post → [core, template, examples]
   - twitter → [twitter]
   - telegram → [telegram]

## Global Invariants (must hold)
- Short, anti‑noise, Bayesian updates
- 1–3 lines per block; 3–6 blocks per blog post
- Conclusion last; calm, precise, honest
- No metaphors, promotion, or performative tone

## Blog Post Skeleton
Headings: Observation → Update → Reasoning → Next  
Sign at the end: “— S. Praevis”

## Pre‑flight Checklist
- One thought per block?
- Noise removed?
- Probability change or rationale stated?

## Post‑flight Checklist
- Beliefs updated (or explicitly unchanged)?
- No emotional/promo wording?
- Conclusion is last?

Paths are relative to /guides/style. Do not load entire guides unless explicitly requested.
