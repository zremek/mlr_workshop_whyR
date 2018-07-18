makeResampleDesc("RepCV")

res = resample(spam.lnr2, spam.task, resampling = cv10, show.info = FALSE)
res

bm = benchmark(learners = list(spam.lnr, spam.lnr2, spam.lnr3, spam.lnr4),
          tasks = spam.task,
          resamplings = cv3)
print(bm)

plotBMRBoxplots(bm, pretty.names = FALSE)
plotBMRSummary(bm)
