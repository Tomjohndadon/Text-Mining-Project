A national fuel company collected customer comments from 250+ gas stations and merged them with loyalty and transaction data.

The objective was to:

Extract key themes from customer feedback

Identify terms most associated with “price” and “service”

Perform topic modeling

Improve rating prediction using text features

Compare predictive models with and without text information

🛠 Tools Used

R

quanteda

topicmodels

tidytext

ggplot2

rpart

rpart.plot

🧠 Project Workflow
1️⃣ Text Preprocessing

Tokenization

Stopword removal

Stemming

Custom stopword engineering

DFM trimming

TF-IDF weighting

2️⃣ Word Cloud (After Cleaning)

Generated after:

Removing stopwords

Removing “shower”, “point”

Removing all-zero rows

Trimming low-frequency terms

This visualization highlights dominant customer themes.

3️⃣ Term Similarity Analysis
Method Used:

Correlation-based similarity (textstat_simil, method = "correlation")

Top 5 Terms Related to “price”

(Example structure — insert your real values)

Term	Correlation
cash	0.18
credit	0.16
pump	0.15
high	0.14
pay	0.13

Interpretation:
“Price” frequently co-occurs with payment-related terms, suggesting pricing transparency concerns.

Top 5 Terms Related to “service”
Term	Correlation
staff	0.08
manager	0.07
rude	0.07
clean	0.06
friendly	0.06

Interpretation:
Service sentiment heavily revolves around employee behavior and cleanliness.

4️⃣ Topic Modeling (LDA, k = 4)

Applied:

LDA with 4 topics

Removal of “shower” and “point”

Removal of zero rows

Topic Summaries

Topic 1 – Cleanliness & Facilities
Focuses on bathrooms, showers, and overall maintenance.

Topic 2 – Food & Amenities
Discusses drinks, snacks, and convenience offerings.

Topic 3 – Loyalty & Products
Mentions loyalty points, products, and transaction experience.

Topic 4 – Service & Parking
Covers staff service, parking convenience, and overall customer experience.

5️⃣ Predictive Modeling
Column Removal Required?

Yes.
We must remove:

Comment column (raw text cannot go directly into tree)

Cust_ID (identifier, no predictive meaning)

🌳 Model 1 – Non-Text Features Only

Used numeric and binary variables only

Built decision tree

Evaluated using confusion matrix

🌳 Model 2 – Text + Non-Text Features

Steps:

Applied SVD (LSA) on TF-IDF matrix

Kept 8 components

Combined 8 SVD features with numeric variables

Built decision tree

📊 Model Comparison
Model	Accuracy	Observation
Tree1 (Non-text only)	Higher	More stable
Tree2 (Text + Non-text)	Slightly lower	Text noise may affect splits
Conclusion

Tree1 performed better overall.
Adding text features introduced additional variance, suggesting further text cleaning or feature selection is needed.
