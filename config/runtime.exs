import Config

if Config.config_env() == :dev do
  DotenvParser.load_file(".env")
end

config :glup,
  env: Config.config_env(),
  username: System.fetch_env!("DATABASE_USERNAME"),
  password: System.fetch_env!("DATABASE_PASSWORD"),
  database: System.fetch_env!("DATABASE_DATABASE"),
  hostname: System.fetch_env!("DATABASE_HOSTNAME")

# Configure your database
config :glup, Glup.Repo,
  username: System.fetch_env!("DATABASE_USERNAME"),
  password: System.fetch_env!("DATABASE_PASSWORD"),
  database: System.fetch_env!("DATABASE_DATABASE"),
  hostname: System.fetch_env!("DATABASE_HOSTNAME"),
  show_sensitive_data_on_connection_error: true,
  pool_size: 10
