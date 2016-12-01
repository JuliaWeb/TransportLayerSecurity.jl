module TransportLayerSecurity

# implementation packages must adhere to the following:

# implement types
# type SSLConfig
#     # hold configuration options
#     # cert/key values, etc.
# end

# constructor that takes cert and key files as inputs and returns a "default" configuration
# function SSLConfig#(cert_file, key_file)
#
# end

# type SSLContext
#     # a TLS-enabled socket for reading requests and sending responses
# end

# to "initialize" a TLS socket w/ a configuration
function setup!#(tls::SSLContext, config::SSLConfig)

end

# "upgrade" a regular TCPSocket to use the TLS SSLContext
function associate!#(tls::SSLContext, tcp::TCPSocket)

end

# perform the https handshake on a configured, initialized TLS SSLContext
function handshake!#(tls::SSLContext)

end

end # module
