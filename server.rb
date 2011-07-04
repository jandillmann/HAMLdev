#!/usr/bin/env ruby

['rubygems', 'sinatra', 'haml'].each { |lib| require lib }

set :views, :scss => 'styles', :haml => 'templates', :default => 'views'
set :haml, :format => :html5

helpers do
    def find_template(views, name, engine, &block)
        _, folder = views.detect { |k,v| engine == Tilt[k] }
        folder ||= views[:default]
        super(folder, name, engine, &block)
    end
end

get '/view/*' do
    haml params[:splat].join('/').to_sym
end

get '/style/*' do
    scss params[:splat].join('/').to_sym
end

get '/' do
    redirect '/view/index.html'
end
