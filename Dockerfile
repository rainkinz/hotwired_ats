ARG BASE_IMAGE_VERSION=3.2.2
ARG NODE_MAJOR=20

FROM ruby:${BASE_IMAGE_VERSION}-slim-bookworm AS build

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl  \
    git \
    gnupg2 \
    libpq-dev \
    libxml2-dev \
    libxslt-dev \
    libffi-dev \
  # && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key -o /etc/apt/keyrings/nodesource.asc \
  # && 'deb [signed-by=/etc/apt/keyrings/nodesource.asc] https://deb.nodesource.com/node_${NODE_MAJOR}.x nodistro main' | tee /etc/apt/sources.list.d/nodesource.list \
  # && apt-get update && apt-get install -y nodejs \
  && rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man \
  && apt-get clean \
  && useradd --create-home docker \
  && mkdir /node_modules && chown docker:docker -R /node_modules /app

# See: https://github.com/nodesource/distributions/issues/1601 for why this is necessary
RUN echo "Package: nodejs" >> /etc/apt/preferences.d/preferences \
    && echo "Pin: origin deb.nodesource.com" >> /etc/apt/preferences.d/preferences \
    && echo "Pin-Priority: 1001" >> /etc/apt/preferences.d/preferences

RUN mkdir -p /etc/apt/keyrings && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list

RUN apt update \
    && apt install -y nodejs \
    && corepack enable yarn && yarn -v

USER docker

COPY --chown=docker:docker Gemfile* ./
COPY --chown=docker:docker package.json *yarn* ./

RUN bundle install --jobs $(nproc)

ARG RAILS_ENV="production"
ARG NODE_ENV="production"
ENV RAILS_ENV="${RAILS_ENV}" \
    NODE_ENV="${NODE_ENV}" \
    PATH="${PATH}:/home/docker/.local/bin" \
    USER="docker"

COPY --chown=docker:docker . .
RUN chmod 0755 bin/*

# RUN yarn install
RUN if [ "${RAILS_ENV}" != "development" ]; then \
  echo "Compiling assets in environment ${RAILS_ENV}"; \
  SECRET_KEY_BASE=dummyvalue rails assets:precompile; fi

FROM build AS console

CMD ["true"]

# FROM ruby:${BASE_IMAGE_VERSION}-slim-buster AS app
FROM build AS app

# WORKDIR /app

ARG RAILS_ENV="production"
ENV RAILS_ENV="${RAILS_ENV}" \
    PATH="${PATH}:/home/docker/.local/bin" \
    USER="docker"

COPY --chown=docker:docker . .

# For Vite
EXPOSE 5173
EXPOSE 3000

CMD ["./script/docker/rails"]