FROM ubuntu:14.04

RUN apt-get update

# prepare packages
RUN apt-get install -y --force-yes build-essential curl git zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt-dev mysql-client libmysqlclient-dev mecab mecab-ipadic libmecab-dev libmagickwand-dev imagemagick

# create user
RUN useradd -m -s /bin/bash rails
RUN echo 'rails:password' | chpasswd
RUN echo 'rails ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/rails

USER rails
ENV HOME /home/rails

# rbenv install
RUN git clone https://github.com/rbenv/rbenv.git ${HOME}/.rbenv
RUN mkdir -p ${HOME}/.rbenv/plugins && git clone https://github.com/sstephenson/ruby-build.git ${HOME}/.rbenv/plugins/ruby-build

# setupt rbenv environments
RUN echo 'export PATH=$HOME/.rbenv/bin:$PATH' >> ${HOME}/.bashrc
RUN echo 'eval "$(rbenv init -)"' >> ${HOME}/.bashrc
ENV PATH ${HOME}/.rbenv/bin:$PATH

# install ruby
RUN rbenv install 2.1.4
RUN rbenv global 2.1.4

RUN eval "$(rbenv init -)" && gem install bundler

# create working directory
RUN mkdir ${HOME}/app

USER rails
WORKDIR ${HOME}/app


EXPOSE 3000

CMD ["/bin/bash"]