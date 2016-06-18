ENVIRON = ENV['BLOG_ENV'] || 'development'

module Configuration
  CONFIG = {
    development: {
      db_host: 'localhost',
      db_port: '8529'
    },
    production: {
      db_host: ENV['DBHOST'],
      db_port: ENV['DBPORT'] || '8529'
    }
  }

  CONFIG_ENV = CONFIG[ENVIRON.to_sym]

  class << self
    def method_missing(method, *args)
      return CONFIG_ENV[method.to_sym] if CONFIG_ENV.key?(method.to_sym)
      super
    end
  end
end
