# README

## Overview

This repo contains the project files for Applied Cryptography's Project 2 by Justin Wang and Zhen Tang. The files implement a basic demo of a blog with some security measures in Ruby on Rails. A SSL certificate is required to showcase TLS/SSL functionality.

This project uses Ruby 2.2.3 with Rails 4.1.16.

## Setup

Install gems from Gemfile:
```
bundle install
```

Create db with standard rake commands (Rails <5):
```
rake db:create db:migrate
```

Start the server using
```
thin start --ssl --ssl-key-file [key] --ssl-cert-file [cert]
```

For local usage, generate a self-signed certificate and add the CA to the browser. The website will be available at `https://localhost:3000` by default.
