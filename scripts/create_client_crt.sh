SERVER=10.64.201.203
PORT=443
CERTIFICATE=../certs/${SERVER}.crt

# Create the certificates hierarchy expected by gitlab
sudo mkdir -p $(dirname "$CERTIFICATE")

# Get the certificate in PEM format and store it
openssl s_client -connect ${SERVER}:${PORT} -showcerts </dev/null 2>/dev/null | sed -e '/-----BEGIN/,/-----END/!d' | sudo tee "$CERTIFICATE" >/dev/null
