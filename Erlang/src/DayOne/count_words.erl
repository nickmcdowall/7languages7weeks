-module(count_words).
-export([count/1]).

%% Didn't use recursion since found this to do the job.
count(Sentence) -> string:words(Sentence).