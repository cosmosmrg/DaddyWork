FROM rails:5.0.0
RUN apt-get update
RUN apt-get install -y build-essential
ENV RAILS_ENV production
COPY webapp/Gemfile* /tmp/
WORKDIR /tmp
RUN bundle install
WORKDIR /myapp
# cache friendly
COPY webapp /myapp
ENV SECRET_KEY_BASE RAILS_ENV=production rails secret
RUN bundle exec rake assets:precompile
EXPOSE 3000
CMD ["./run.sh"]
