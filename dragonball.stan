
data {
  int<lower=0> N;
  int<lower=0, upper=1> win[N];
  vector[N] percent_diff;
}

parameters {
  real<lower=0> beta;
}

transformed parameters {
  vector[N] log_odds;
  
  // Logistic regression model
  // Intercept = 0, when percent_diff is 0, log_odds = 0, i.e. 50% probability
  log_odds = beta * percent_diff;
}


model {
  beta ~ normal(0.3, 1);
  win ~ bernoulli_logit(log_odds);
}

generated quantities {
  vector[N] win_prob;
  vector[11] win_prediction;
  vector[11] win_predictor;
  
  win_prob = inv_logit(log_odds);
  
  for (i in 1:11) {
    win_prediction[i] = inv_logit(beta * (i-1) * 10 );
    win_predictor[i] = (i-1)*10;
  }
}
