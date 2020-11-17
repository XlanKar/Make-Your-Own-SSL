# İşiniz Bittiğinde Şu Komutları Girin (SSL DOĞRULAYICI) : openssl verify -CAfile ca-cert.pem server-cert.pem
# Enter the following commands when you are finished (SSL verifier) : openssl verify -CAfile ca-cert.pem server-cert.pem
# ŞİFRELEME TÜRLERİ : rsa:4096 rsa:2048
# Encryption types: rsa:4096 rsa:2048
rm *.pem
# CA'nın özel anahtarını ve kendinden imzalı sertifikasını oluştur
# Create ca's private key and self-signed certificate
openssl req -x509 -newkey rsa:4096 -days 365 -nodes -keyout ca-key.pem -out ca-cert.pem -subj "/C=ÜLKE KISALTMASI ÖRNEK : TR/ST=İL/L=İLÇE/O=KURULUŞ ADI/OU=BİRİM ADI/CN=*.DOMAİN/emailAddress=E-POSTA"

# CA's self-signed certificate
echo "CA'nın kendinden imzalı sertifikası"
openssl x509 -in ca-cert.pem -noout -text

# Web sunucusunun özel anahtarı ve sertifika imzalama isteği oluştur (CSR)
# Generate web server's private key and certificate signing request (CSR)
openssl req -newkey rsa:4096 -nodes -keyout server-key.pem -out server-req.pem -subj "/C=ÜLKE KISALTMASI ÖRNEK : TR/ST=İL/L=İLÇE/O=KURULUŞ ADI/OU=BİRİM ADI/CN=*.DOMAİN/emailAddress=E-POSTA"

# Web sunucusunun CSR'SİNİ imzalamak ve imzalı sertifikayı geri almak için CA'nın özel anahtarını kullanın.
# Use the CA's private key to sign the CSR of the Web server and undo the signed certificate.
openssl x509 -req -in server-req.pem -days 60 -CA ca-cert.pem -CAkey ca-key.pem -CAcreateserial -out server-cert.pem -extfile server-ext.cnf

# Server's signed certificate
echo "Sertifika Oluşturucu"
openssl x509 -in server-cert.pem -noout -text