# Gender, Education, and Voting Conservative

### A Replication and Extension of "Education and Voting Conservative: Evidence from a Major Schooling Reform in Great Britain" (Marshall 2015)

Marshall (2015) shows the causal effect of additional years of schooling on voting conservative in his analysis og voting records before and after the British 1947 school-leaving age reform. Marshall's figures and the results of his tables were replicated in Stata, but an update in the rdrobust package lead to my modification of his bandwidth selection code, and thus slightly different coefficients. In an extension of Marshall's work I investigated how his observed effect differed between genders. Running rdrobust and creating regression discontinuity figures on male and female subsets of the data revealed the effect of more years of education increasing likelihood of voting conservative was much stronger in women than men. This finding could complicate Marshall's argument that more education leads to higher income and then to more conservative political opinions and perhaps reveals something about the differing effect of education on men and women.