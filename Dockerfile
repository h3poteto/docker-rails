FROM ruby:2.3.1-slim

# prepare packages
RUN set -x && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
      build-essential \
      locales task-japanese \
      git \
      curl \
      mysql-client \
      libmysqlclient-dev \
      libmagickwand-dev \
      imagemagick && \
      rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*


# create user
RUN useradd -m -s /bin/bash rails && \
    mkdir -p /usr/src/app && \
    chown rails:rails /usr/src/app $BUNDLE_APP_CONFIG

USER rails

WORKDIR /usr/src/app

ENV BUNDLE_APP_CONFIG /usr/src/app/.bundle

EXPOSE 3000 3000

CMD ["/bin/bash"]
