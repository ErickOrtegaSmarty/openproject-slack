FROM openproject/community:12.0.7

RUN export OPENPROJECT_ROOT=/app/
COPY Gemfile.plugins /app/

WORKDIR /app/
COPY ./openproject-slack /app/openproject-slack

RUN bundle config unset deployment && bundle install && bundle config set deployment 'true'
RUN ./docker/prod/setup/postinstall.sh
