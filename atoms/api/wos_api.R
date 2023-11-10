# Authenticate user credentials
sid <- auth("your_username", "your_password")

# Create a vector of UT-based queries
queries <- create_ut_queries(your_vector_of_UTs)

# Download data for each query
data <- pull_wos_apply(queries)
