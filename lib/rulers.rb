# frozen_string_literal: true

require_relative "rulers/version"
require "rulers/array"
require "rulers/routing"

module Rulers
  class Error < StandardError; end

  class Application
    def call(env)
      if env['PATH_INFO'] == '/favicon.ico'
        return [404, {'Content-Type' => 'text/html'}, []]
      end

      if env['PATH_INFO'] == '/'
        return [200, {'Content-Type' => 'text/html'}, ['Welcome to my homepage']]
      end

      klass, act = get_controller_and_action(env)
      controller = klass.new(env)
      begin
        text = controller.send(act)
        `echo debug > debug.txt`;
        [200, {'Content-Type' => 'text/html'}, [text]]
      rescue => exception
        [500, {'Content-Type' => 'text/html'}, ['Whoopsie!']]
      end
    end
  end

  class Controller
    def initialize(env)
      @env = env
    end

    def env
      @env
    end
  end
end
