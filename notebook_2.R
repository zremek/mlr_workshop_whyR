# https://hub.mybinder.org/user/ja-thomas-whyr_2018_intro_mlr-6orfzz9p/notebooks/notebook2.ipynb

data(spam, package = "kernlab")
spam_task = makeClassifTask(data = spam, target = "type")
l = makeLearner("classif.rpart", predict.type = "prob")

# resampling
(res_cv10 = resample(l, spam_task, resampling = cv10, show.info = FALSE))

# benchmarking
l1 = makeLearners(cls = c("classif.featureless", "classif.lda",
                          "classif.multinom", "classif.rpart",
                          "classif.randomForest"), 
                  predict.type = "prob")

bench = benchmark(learners = l1, 
          tasks = spam_task, 
          resamplings = cv5, 
          measures = list(mlr::auc, mlr::timetrain))

print(bench)
plotBMRBoxplots(bench)
plotBMRSummary(bench)          

ggplot(data = print(bench) %>% as.data.frame()) +
  geom_point(aes(x = learner.id, 
                 y = auc.test.mean, 
                 size = timetrain.test.mean),
             alpha = .5) +
  coord_flip()

# tuning - not finished
getParamSet(("classif.randomForest"))

l_rf_tuning = makeLearner("classif.randomForest",
                          mtry = 9,
                          nodesize = 2,
                          sampsize = 3000)

# nested resampling - pozwala na pozostawienie części zbioru danych 
# żeby testować na danych "nie widzianych" wcześniej