ARG POSTGRES_VERSION=alpine
FROM postgres:${POSTGRES_VERSION}

ARG PGDATA
RUN mkdir -p ${PGDATA} && chmod 700 ${PGDATA} && chown -R postgres:root ${PGDATA}

CMD ["postgres"]

EXPOSE 5432