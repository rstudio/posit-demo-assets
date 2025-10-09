# SovereignWealth Capital - Synthetic Portfolio Data Generation
# ============================================================
# This script generates synthetic investment portfolio data for demonstration purposes.
# All data is artificially created using AI and does not represent real investments or returns.

library(tidyverse)
library(lubridate)

set.seed(42)

# Generate portfolio holdings data
# ---------------------------------
# Represents current holdings across diversified asset classes

generate_holdings <- function() {

  asset_classes <- c("Equities", "Fixed Income", "Real Estate", "Private Equity",
                     "Infrastructure", "Natural Resources", "Cash & Equivalents")

  sectors <- list(
    "Equities" = c("Technology", "Healthcare", "Manufacturing", "Energy", "Retail"),
    "Fixed Income" = c("Government Bonds", "Corporate Bonds", "Municipal Bonds"),
    "Real Estate" = c("Commercial Property", "Residential Development", "Industrial"),
    "Private Equity" = c("Growth Capital", "Buyout Funds", "Venture Capital"),
    "Infrastructure" = c("Transportation", "Utilities", "Communications"),
    "Natural Resources" = c("Timber", "Agriculture", "Energy"),
    "Cash & Equivalents" = c("Money Market", "Short-term Treasuries")
  )

  holdings <- map_df(asset_classes, function(asset_class) {
    n_holdings <- sample(8:15, 1)
    available_sectors <- sectors[[asset_class]]

    tibble(
      investment_id = paste0("INV-", asset_class |> str_replace_all(" ", ""), "-",
                             sprintf("%03d", 1:n_holdings)),
      investment_name = paste("Investment", LETTERS[1:n_holdings]),
      asset_class = asset_class,
      sector = sample(available_sectors, n_holdings, replace = TRUE),
      market_value = rnorm(n_holdings, mean = 5000000, sd = 2000000) |> abs(),
      cost_basis = NA_real_,  # Realistic missing data
      acquisition_date = sample(seq(as.Date("2015-01-01"), as.Date("2024-01-01"), by = "day"),
                                n_holdings, replace = TRUE),
      current_yield = case_when(
        asset_class == "Fixed Income" ~ rnorm(n_holdings, 0.04, 0.015),
        asset_class == "Real Estate" ~ rnorm(n_holdings, 0.06, 0.02),
        asset_class == "Cash & Equivalents" ~ rnorm(n_holdings, 0.02, 0.005),
        TRUE ~ NA_real_
      ),
      risk_rating = sample(c("Low", "Medium-Low", "Medium", "Medium-High", "High"),
                          n_holdings, replace = TRUE,
                          prob = c(0.1, 0.2, 0.4, 0.2, 0.1))
    )
  })

  # Add cost basis with some missing values (~15% missing)
  holdings <- holdings |>
    mutate(
      cost_basis = if_else(
        runif(n()) > 0.15,
        market_value * runif(n(), 0.7, 1.3),
        NA_real_
      )
    )

  return(holdings)
}

# Generate historical performance data
# ------------------------------------
# Monthly returns for each investment over the past 5 years

generate_performance <- function(holdings) {

  months <- seq(floor_date(today() - years(5), "month"),
                floor_date(today(), "month"),
                by = "month")

  performance <- holdings |>
    select(investment_id, asset_class, risk_rating) |>
    crossing(month_end = months) |>
    mutate(
      # Generate returns based on asset class and risk
      base_return = case_when(
        asset_class == "Equities" ~ rnorm(n(), 0.008, 0.04),
        asset_class == "Fixed Income" ~ rnorm(n(), 0.003, 0.01),
        asset_class == "Real Estate" ~ rnorm(n(), 0.005, 0.02),
        asset_class == "Private Equity" ~ rnorm(n(), 0.012, 0.05),
        asset_class == "Infrastructure" ~ rnorm(n(), 0.006, 0.015),
        asset_class == "Natural Resources" ~ rnorm(n(), 0.004, 0.045),
        asset_class == "Cash & Equivalents" ~ rnorm(n(), 0.002, 0.003),
        TRUE ~ 0
      ),
      # Add market volatility periods
      market_shock = case_when(
        month_end >= as.Date("2020-03-01") & month_end <= as.Date("2020-04-01") ~ -0.15,
        month_end >= as.Date("2022-01-01") & month_end <= as.Date("2022-06-01") ~ -0.03,
        TRUE ~ 0
      ),
      monthly_return = base_return + market_shock,
      # Introduce realistic missing data (~5% missing for recent periods)
      monthly_return = if_else(
        runif(n()) > 0.05 & month_end >= today() - months(12),
        NA_real_,
        monthly_return
      )
    ) |>
    select(investment_id, month_end, monthly_return)

  return(performance)
}

# Generate transaction history
# ----------------------------
# Buy/sell transactions over time

generate_transactions <- function(holdings) {

  transactions <- holdings |>
    select(investment_id, asset_class, acquisition_date) |>
    mutate(
      n_transactions = sample(1:8, n(), replace = TRUE)
    ) |>
    uncount(n_transactions) |>
    group_by(investment_id) |>
    mutate(
      transaction_date = acquisition_date + days(cumsum(sample(30:365, n(), replace = TRUE))),
      transaction_date = if_else(transaction_date > today(), today() - days(sample(1:90, n())), transaction_date),
      transaction_type = sample(c("Buy", "Sell", "Distribution", "Reinvestment"),
                               n(), replace = TRUE, prob = c(0.35, 0.15, 0.25, 0.25)),
      amount = abs(rnorm(n(), 500000, 300000)),
      # Some transactions missing amount data (~8% missing)
      amount = if_else(runif(n()) > 0.08, amount, NA_real_),
      transaction_id = paste0("TXN-", row_number(), "-", format(transaction_date, "%Y%m"))
    ) |>
    ungroup() |>
    arrange(transaction_date) |>
    select(transaction_id, investment_id, transaction_date, transaction_type, amount)

  return(transactions)
}

# Generate benchmark data
# -----------------------
# Market indices for comparison

generate_benchmarks <- function() {

  months <- seq(floor_date(today() - years(5), "month"),
                floor_date(today(), "month"),
                by = "month")

  benchmarks <- tibble(month_end = months) |>
    mutate(
      sp500_return = rnorm(n(), 0.008, 0.035),
      bond_index_return = rnorm(n(), 0.003, 0.008),
      real_estate_index = rnorm(n(), 0.005, 0.015),
      # Add COVID shock
      sp500_return = if_else(
        month_end >= as.Date("2020-03-01") & month_end <= as.Date("2020-04-01"),
        sp500_return - 0.15,
        sp500_return
      ),
      # Some missing benchmark data (~3% missing)
      sp500_return = if_else(runif(n()) > 0.03, sp500_return, NA_real_),
      bond_index_return = if_else(runif(n()) > 0.03, bond_index_return, NA_real_)
    )

  return(benchmarks)
}

# Main execution
# --------------

cat("Generating synthetic portfolio data...\n")

cat("  - Creating holdings data...\n")
holdings <- generate_holdings()
write_csv(holdings, "data/synthetic-portfolio-holdings.csv")

cat("  - Creating performance history...\n")
performance <- generate_performance(holdings)
write_csv(performance, "data/synthetic-performance-history.csv")

cat("  - Creating transaction history...\n")
transactions <- generate_transactions(holdings)
write_csv(transactions, "data/synthetic-transactions.csv")

cat("  - Creating benchmark data...\n")
benchmarks <- generate_benchmarks()
write_csv(benchmarks, "data/synthetic-benchmarks.csv")

cat("\nData generation complete!\n")
cat("Generated files:\n")
cat("  - synthetic-portfolio-holdings.csv:", nrow(holdings), "holdings\n")
cat("  - synthetic-performance-history.csv:", nrow(performance), "monthly records\n")
cat("  - synthetic-transactions.csv:", nrow(transactions), "transactions\n")
cat("  - synthetic-benchmarks.csv:", nrow(benchmarks), "benchmark periods\n")
cat("\nNote: Data includes realistic missing values for demonstration purposes.\n")
