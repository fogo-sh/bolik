FROM elixir:1.13
WORKDIR /app
ENV MIX_ENV=prod

COPY lib ./lib
COPY mix.exs .
COPY mix.lock .
COPY index.html .

RUN mix local.rebar --force \
    && mix local.hex --force \
    && mix deps.get \
    && mix release

EXPOSE 4001
CMD ["_build/prod/rel/bolik/bin/bolik", "start"]
