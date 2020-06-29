# frozen_string_literal: true

module Slack
  module BlockKit
    module Composition; end
    module Element; end
    module Layout; end

    VERSION = '0.8.0'

    Dir[File.join(__dir__, 'block_kit', 'composition', '*.rb')].sort.each { |file| require file }
    Dir[File.join(__dir__, 'block_kit', 'element', '*.rb')].sort.each { |file| require file }
    Dir[File.join(__dir__, 'block_kit', 'layout', '*.rb')].sort.each { |file| require file }
    Dir[File.join(__dir__, 'block_kit', '*.rb')].sort.each { |file| require file }
    Dir[File.join(__dir__, 'surfaces', '*.rb')].sort.each { |file| require file }

    module_function

    def blocks
      blocks = Blocks.new

      yield(blocks) if block_given?

      blocks
    end

    def home(blocks: nil)
      home_surface = Slack::Surfaces::Home.new(blocks: blocks)

      yield(home_surface) if block_given?

      home_surface
    end

    def modal(blocks: nil)
      modal_surface = Slack::Surfaces::Modal.new(blocks: blocks)

      yield(modal_surface) if block_given?

      modal_surface
    end

    def message(blocks: nil,
                channel: nil, thread_ts: nil, as_user: nil)
      message_surface = Slack::Surfaces::Message.new(blocks: blocks,
                                                     channel: channel,
                                                     thread_ts: thread_ts,
                                                     as_user: as_user)

      yield(message_surface) if block_given?

      message_surface
    end
  end
end
