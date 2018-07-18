# https://hub.mybinder.org/user/ja-thomas-whyr_2018_intro_mlr-6orfzz9p/notebooks/notebook1.ipynb

data(spam, package = "kernlab")
summary(spam)
str(spam)

spam.task = makeClassifTask(data = spam, target = "type")
print(spam.task)

listLearners(spam.task, warn.missing.packages = FALSE) %>% 
  select(class, package) %>% as.data.frame()

spam.lnr = makeLearner("classif.lda", predict.type = "prob")

set.seed(123)
n = getTaskSize(spam.task)
spam.train = sample(n, size = n - 1000)
spam.test = setdiff(1:n, spam.train)

# d*) Ensure that the fraction between `"spam"` and `"nonspam"` 
# is the training and test set is the same as in the full dataset. ?
summary(spam$type) %>% prop.table()
summary(spam$type[spam.train]) %>% prop.table()
summary(spam$type[spam.test]) %>% prop.table()
###

spam.model1 = train(spam.lnr, spam.task, spam.train)

spam.predi1 = predict(spam.model1, task = spam.task, subset = spam.test)

performance(spam.predi1, measures = list(mlr::acc, mlr::auc))

getParamSet(x = spam.lnr)

########

spam.lnr2 = makeLearner("classif.svm", predict.type = "prob")
spam.model2 = train(spam.lnr2, spam.task, spam.train)
spam.predi2 = predict(spam.model2, task = spam.task, subset = spam.test)
performance(spam.predi2, measures = list(mlr::acc, mlr::auc))

########

spam.lnr3 = makeLearner("classif.probit", predict.type = "prob")
spam.model3 = train(spam.lnr2, spam.task, spam.train)
spam.predi3 = predict(spam.model3, task = spam.task, subset = spam.test)
performance(spam.predi3, measures = list(mlr::acc, mlr::auc))

########

spam.lnr4 = makeLearner("classif.naiveBayes", predict.type = "prob")
spam.model4 = train(spam.lnr4, spam.task, spam.train)
spam.predi4 = predict(spam.model4, task = spam.task, subset = spam.test)
performance(spam.predi4, measures = list(mlr::acc, mlr::auc))

## my best:
performance(spam.predi2, measures = list(mlr::acc, mlr::auc))
print(spam.model2)
print(spam.predi2)
