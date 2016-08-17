# RestClient needs persistent connections

This is a demo repository, demonstrating the benefits of persistent
connections.

It is directly related to

* https://github.com/rest-client/rest-client/issues/453
* https://github.com/drbrain/net-http-persistent

To run this script, have ruby and bundler installed, then run

    bundle install
    ruby speedtest.rb

This should yield output along these lines:

    timing 20 requests to https://www.example.com
                                    user     system      total        real
    Plain Net::HTTP#get         1.703000   0.391000   2.094000 ( 11.465042)
    Persistent HTTP#request     0.031000   0.000000   0.031000 (  2.692170)
    RestClient#get              0.562000   0.015000   0.577000 ( 10.478902)

The difference is most pronounced with https connections, most of the difference will probably be due to TLS Handshake round trips.
