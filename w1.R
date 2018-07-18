# https://hub.mybinder.org/user/ja-thomas-whyr_2018_intro_mlr-3co83rre/tree/

# celem stworzenia tego pakietu było 'domain-specyfic language for ML in R'
# czyli każdy algorytm ma mieć taki sam sposób kodowania

### koncepcja mlr:
# TASK - wraper do data frame + meta informacje + podajemy cel, podzial na train i test set
# LEARNER - algorytm ml jako abstrakcja
# MODEL - algorytm wytrenowany na naszych danych
# PREDICTION
# EVALUATE

# https://mlr-org.slack.com/ slack channel

# https://mlr-org.github.io/mlr-tutorial/release/html/

data("iris")
task = makeClassifTask(data = iris, target = "Species")
lrn = makeLearner("classif.lda")

