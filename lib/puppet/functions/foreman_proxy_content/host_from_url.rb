require 'uri'

# @summary Parses a URL and returns the host
#
# @example Calling the function
#   $host = foreman_proxy_content::host_from_url('https://test.example.com')
Puppet::Functions.create_function(:'foreman_proxy_content::host_from_url') do
  # @param url URL to parse
  # @return The host found within the URL
  dispatch :host do
    param 'Stdlib::HTTPUrl', :url
    return_type 'Stdlib::Host'
  end

  def host(url)
    uri = URI(url)
    uri.host
  end
end
