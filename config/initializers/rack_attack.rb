class Rack::Attack
  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

  Rack::Attack.throttle('api_throttle', limit: 100, period: 1.day) do |req|
    if req.path.start_with?('/api/v1/')
      req.get_header('TENANT-API-KEY')
    end
  end

  Rack::Attack.throttle('api_tenant_throttle', limit: 1, period: 10.seconds) do |req|
    if req.path.start_with?('/api/v1/') && req.env['rack.attack.matched'] == 'api_throttle'
      req.get_header('TENANT-API-KEY')
    end
  end
end
