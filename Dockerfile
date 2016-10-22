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

# localeの設定
ENV LC_ALL ja_JP.UTF-8
ENV LC_CTYPE ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP.UTF-8

WORKDIR /usr/src/app

EXPOSE 3000 3000

CMD ["/bin/bash"]
