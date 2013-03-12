require 'erb'
require 'ostruct'

module Tunnels
  class Generator

    def initialize(template_name)
      template_path = File.join(File.dirname(__FILE__), 'templates', "#{template_name}.erb")
      @template = ERB.new(File.read(template_path))
    end

    def write(path, locals = {})
      File.open(path, 'w') { |f| f.write(render(locals)) }
    end

  private

    def render(locals = {})
      @template.result(OpenStruct.new(locals).instance_eval { binding })
    end

  end
end
