class UrlShortenerService
  def initialize(destination)
    @destination   = destination
    @rebrandly_api = Rebrandly::Api.new
    @domain        = domain
  end

  def call
    return unless !@destination.empty? && @domain

    rebrandly_link = @rebrandly_api.shorten(@destination, domain: @domain.to_h)

    "http://#{rebrandly_link.short_url}"
  end

  private

  def domain
    selected_domains = @rebrandly_api.domains.select do |domain|
      domain.full_name == ENV['REBRANDLY_DOMAIN_FULL_NAME'] && domain.active
    end

    return if selected_domains.empty?

    selected_domains.first
  end
end
