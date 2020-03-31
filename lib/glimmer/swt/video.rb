require_relative 'custom_widget'
require_relative 'g_color'

#TODO display progress wheel while loading video

module Glimmer
  module SWT
    class Video
      PROPERTIES_OBSERVED = [
        'playing',
        'paused',
        'ended',
        'started',
        'remaining',
        'current_time',
      ]

      include_package 'org.eclipse.swt.browser'

      include Glimmer::SWT::CustomWidget

      options :file, :url
      option :autoplay, true
      option :controls, true
      option :looped, false
      option :background, :white
      option :fit_to_width, true
      option :fit_to_height, true
      option :offset_x, 0
      option :offset_y, 0

      alias autoplay? autoplay
      alias controls? controls
      alias looped? looped
      alias fit_to_width? fit_to_width
      alias fit_to_height? fit_to_height

      def body
        browser {
          text <<~HTML
            <html>
              <head>
                <style id="style">
                  body {
                    margin: 0;
                    padding: 0;
                  }
                </style>
                <style id="style-body-background">
                  body {
                    background: #{browser_body_background};
                  }
                </style>
                <style id="style-body-offset-x">
                  body {
                    margin-left: #{browser_body_offset_x}px;
                  }
                </style>
                <style id="style-body-offset-y">
                  body {
                    margin-top: #{browser_body_offset_y}px;
                  }
                </style>
              </head>
              <body>
                <video id="video" #{browser_video_width} #{browser_video_height} #{browser_video_loop} #{browser_video_controls} #{browser_video_autoplay}>
                  <source id="source" src="#{source}" type="video/mp4">
                Your browser does not support the video tag.
                </video>
              </body>
            </html>
          HTML
        }
      end

      def source
        file ? "file://#{file}" : url
      end

      def play
        video_action('play')
      end

      def pause
        video_action('pause')
      end

      private

      def video_action(action)
        widget.execute("document.getElementById('video').#{action}()")
      end

      def browser_video_autoplay
        'autoplay' if autoplay?
      end

      def browser_video_controls
        'controls' if controls?
      end

      def browser_video_loop
        'loop' if looped?
      end

      def browser_video_width
        "width='100%'" if fit_to_width
      end

      def browser_video_height
        "height='100%'" if fit_to_height
      end

      def browser_body_background
        color = background
        if color.is_a?(Symbol) || color.is_a?(String)
          color = GColor.color_for(parent.widget.getDisplay, color)
        elsif color.is_a?(GColor)
          color = color.color
        end
        "rgba(#{color.getRed}, #{color.getGreen}, #{color.getBlue}, #{color.getAlpha})"
      end

      def browser_body_offset_x
        offset_x
      end

      def browser_body_offset_y
        offset_y
      end
    end
  end
end