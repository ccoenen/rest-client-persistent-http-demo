ENV['SSL_CERT_FILE']="./cacert.pem"

require 'benchmark'
require 'rest-client'
require 'net/http/persistent'

requests = 20
uri = URI('https://www.example.com')

puts "timing #{requests} requests to #{uri}"

Benchmark.bm(25) do |x|
  x.report("Plain Net::HTTP#get") do
    for i in 1..requests
      Net::HTTP.get uri
    end
  end

  x.report("Persistent HTTP#request") do
    http = Net::HTTP::Persistent.new 'some-nice-pool-name'
    for i in 1..requests
      http.request uri
    end
  end

  x.report("RestClient#get") do
    for i in 1..requests
      RestClient.get uri.to_s
    end
  end

  ## not yet implemented
  # x.report("RestClient#get /w Persistent HTTP") do
  #   for i in 1..requests
  #     RestClient.get uri.to_s
  #   end
  # end
end
