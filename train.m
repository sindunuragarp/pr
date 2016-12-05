function [ w ] = train( train_data , classifier)
%TRAIN returns the trained classifier. Parameterized for testing and
%debugging only, should be delivered non-parameterized.
    w = classifier(train_data);
end

