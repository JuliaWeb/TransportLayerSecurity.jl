# TransportLayerSecurity

[![Build Status](https://travis-ci.org/JuliaWeb/TransportLayerSecurity.jl.svg?branch=master)](https://travis-ci.org/JuliaWeb/TransportLayerSecurity.jl)

An API package defining a generic TLS interface allowing "user packages" to rely on a consistent set of types and functions to enable TLS communication, and encouraging "implementation packages" to implement the types and functions to become "swappable" candidates in "user packages".

To satisfy the interface, an implementing package should define:

* An `SSLConfig` type holding various options and configurations
* A constructor for `SSLConfig` with the signature `SSLConfig(cert_file::String, key_file::String)` constructing a "default" configuration given cert and key files
* An `SSLContext` type representing a TLS-enable socket connection, a subtype of `IO` to allow reading requests from and writing responses to under TLS
* A function `setup!(tls::SSLContext, config::SSLConfig)` that applies the `SSLConfig` configurations to a `SSLContext` socket
* A function `associate!(tls::SSLContext, tcp::TCPSocket)` to associate a regular client TCPSocket with a TLS-enabled `SSLContext`
* A function `handshake!(tls::SSLContext)` that performs the necessary handshake to initialize an https session

Users can then use this like functionality:

```julia
# load a package implementing the TransportLayerSecurity interface
using MbedTLS
# create a constant reference variable to our current TLS library
const TLS = MbedTLS

# create a default configuration
config = TLS.SSLConfig(cert_file, key_file)

# create a TLS socket
tls = TLS.SSLContext()

# setup our TLS socket with our configuration
TLS.setup!(tls, config)

# associate a client TCPSocket with our TLS socket
tcp = TCPSocket()
TLS.associate!(tls, tcp)

# perform TLS handshake to start a valid https session
# encrypted requests and responses can now be transferred over our TLS socket `tls`
TLS.handshake!(tls)

# read
bytes = readavailable(tls)
# write
write(tls, response)
```

This allows a user package to easily swap out a TLS implementation to another library if necessary.
