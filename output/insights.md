
1. **Class distribution:** The cleaned dataset contains 1945 comments:
942 Ham and 1003 Spam.
Both classes are substantially represented, so per-class results should
be considered alongside overall accuracy.

2. **Comment length:** Spam averages
21.98 words and
116.89 characters.
Ham averages 9.20 words and
47.86 characters.
Length helps describe differences, but cannot identify every comment correctly.

3. **Group vocabulary:** Ham's leading filtered word is "song"
with 224 occurrences. Spam's is "check"
with 559 occurrences.
These words provide clues about language use. Counts also depend on group
size and comment length; they count word occurrences, not distinct comments.

4. **Stopwords:** Before English stopword removal, the leading displayed word
is "this" with 737 occurrences.
After removal, it is "check" with 572 occurrences.
Removing common grammatical words exposes more descriptive vocabulary.

5. **Correlation:** Character count and word count have correlation
0.988. Word count and average word length have correlation
-0.129. Values closer to zero indicate weaker linear relationships.
Several features describe the same text and may contain overlapping information.
Correlation does not imply causation.

6. **Detected links:** Explicit http/https/www links appear in
19.04% of Spam and 1.17% of Ham.
Comparing these rates helps assess whether detected links distinguish the groups.
A link alone is not proof of spam. The pattern misses bare domains.
