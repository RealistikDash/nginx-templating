FROM nginx

WORKDIR /
COPY ./fill_variables.sh /fill_variables.sh
RUN chmod +x /fill_variables.sh

COPY ./templates /templates

ENTRYPOINT [ "/fill_variables.sh" ]
