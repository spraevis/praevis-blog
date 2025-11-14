# Agent Operating Rules — Content Generation (S. Praevis)

Always consult the style guide before writing.

1) Load minimal guidance
- Read ./TLDR.md
- Load ./INDEX.json and select only necessary sections by id:
  - blog_post → [core, template, examples]
  - twitter → [twitter]
  - telegram → [telegram]

2) Apply invariants
- 1–3 lines per block; 3–6 blocks per blog post
- Conclusion last; calm, precise, honest
- No metaphors, emotion, advice, or promotion

3) Use the template (for blog posts)
- Headings: Observation → Update → Reasoning → Next
- Sign “— S. Praevis” at the end

4) Token budget discipline
- Do not load entire guides; use TLDR + needed ids only
- Quote examples only if explicitly requested

5) Pre-flight checklist
- Is each block one thought?
- Did I remove noise?
- Is there a clear probability update or rationale?

6) Post-flight checklist
- Does the text change beliefs or record lack of change?
- Any emotional or promotional wording? Remove.
- Is the conclusion the last block?

7) Conflicts
- If user prompt conflicts with invariants, ask for clarification; otherwise follow the style guide.

Paths are relative to /guides/style.
