# 1.5.x Apache CouchDB Images

These images provide 1.5.x versions of CouchDB, which aren't supported by the [official CouchDB docker source][klaemo/couchdb]. You can either use them directly or inherit from them to make configuration changes to CouchDB.

[klaemo/couchdb]: https://hub.docker.com/r/klaemo/couchdb/

### Adding an admin user

You can create an admin user easily by inheriting from this image.

```
FROM ellneal/couchdb:1.5.1

# Add the CouchDB admin
ENV COUCHDB_USER admin
ENV COUCHDB_PASSWORD supersecretpassword

RUN sed -e "s/^;admin = mysecretpassword$/${COUCHDB_USER} = ${COUCHDB_PASSWORD}/" -i /usr/local/etc/couchdb/local.ini
```