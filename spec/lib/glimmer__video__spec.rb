require "spec_helper"

module GlimmerSpec
  describe "Glimmer Video" do
    include Glimmer

    before do
      @original_temp = ENV['temp']
    end

    after do
      if @target
        @target.async_exec do
          @target.dispose
        end
        @target.start_event_loop
      end
      ENV['temp'] = @original_temp
    end

    let(:video_file) { File.expand_path('../../fixtures/videos/Pepa-creativeCommonsMp4956_512kb.mp4', __FILE__) }
    let(:video_url) { "http://www.youtube.com/fdajiew" }
    let(:video_url_truncated) { "www.youtube.com/fdajiew" }

    it "sets video source by file option argument" do
      @target = shell
      @target.content {
        @video = video(file: video_file) {
          on_completed {
            expect(@video.swt_widget.evaluate("return document.getElementById('source').src")).to eq("file://#{video_file}")
          }
        }
      }
    end

    it "sets video source by url option argument" do
      @target = shell
      @target.content {
        @video = video(url: video_url) {
          on_completed {
            expect(@video.swt_widget.evaluate("return document.getElementById('source').src")).to eq(video_url)
          }
        }
      }
    end

    it 'sets video source by uri:classloader file (JAR file path)' do
      @target = shell
      @target.content {
        @video = video(file: "uri:classloader://#{video_file}") {
          on_completed {
            expect(@video.swt_widget.evaluate("return document.getElementById('source').src")).to eq("file:///tmp/glimmer/lib/glimmer/ui/video/#{video_file}")
            expect(Dir['/tmp/glimmer/lib/glimmer/ui/video/*'].to_a.size).to be > 0
          }
        }
      }
    end

    it 'sets video source by uri:classloader file (JAR file path) with ENV["temp"] set for windows' do
      ENV['temp'] = '/tmp/tmp'
      @target = shell
      @target.content {
        @video = video(file: "uri:classloader://#{video_file}") {
          on_completed {
            expect(@video.swt_widget.evaluate("return document.getElementById('source').src")).to eq("file:///tmp/tmp/glimmer/lib/glimmer/ui/video/#{video_file}")
            expect(Dir['/tmp/tmp/glimmer/lib/glimmer/ui/video/*'].to_a.size).to be > 0
          }
        }
      }
    end

    it "autoplays video by default" do
      @target = shell
      @target.content {
        @video = video(file: video_file) {
          on_completed {
            expect(@video.swt_widget.evaluate("return document.getElementById('video').autoplay")).to eq(true)
          }
        }
      }
    end

    it "displays video controls by default" do
      @target = shell
      @target.content {
        @video = video(file: video_file) {
          on_completed {
            expect(@video.swt_widget.evaluate("return document.getElementById('video').controls")).to eq(true)
          }
        }
      }
    end

    it "does not display video controls when specified as an option argument" do
      @target = shell
      @target.content {
        @video = video(file: video_file, controls: false) {
          on_completed {
            expect(@video.swt_widget.evaluate("return document.getElementById('video').controls")).to eq(false)
          }
        }
      }
    end

    it "does not loop video by default" do
      @target = shell
      @target.content {
        @video = video(file: video_file) {
          on_completed {
            expect(@video.swt_widget.evaluate("return document.getElementById('video').loop")).to eq(false)
          }
        }
      }
    end

    it "loops video when specified as an option argument" do
      @target = shell
      @target.content {
        @video = video(file: video_file, looped: true) {
          on_completed {
            expect(@video.swt_widget.evaluate("return document.getElementById('video').loop")).to eq(true)
          }
        }
      }
    end

    it 'sets background to white by default' do
      @target = shell
      @target.content {
        @video = video(file: video_file) {
          on_completed {
            expect(@video.swt_widget.evaluate("return document.getElementById('style-body-background').innerHTML")).to include("rgba(255, 255, 255, 255)")
          }
        }
      }
    end

    it 'sets background to black with option argument' do
      @target = shell
      @target.content {
        @video = video(file: video_file, background: :black) {
          on_completed {
            expect(@video.swt_widget.evaluate("return document.getElementById('style-body-background').innerHTML")).to include("rgba(0, 0, 0, 255)")
          }
        }
      }
    end

    it 'fits video to width by default' do
      @target = shell
      @target.content {
        @video = video(file: video_file) {
          on_completed {
            expect(@video.swt_widget.evaluate("return document.getElementById('video').width")).to eq(100.0)
          }
        }
      }
    end

    it 'does not fit video to width when specified with fit_to_width option argument' do
      @target = shell
      @target.content {
        @video = video(file: video_file, fit_to_width: false) {
          on_completed {
            expect(@video.swt_widget.evaluate("return document.getElementById('video').width")).to eq(0.0)
          }
        }
      }
    end

    it 'fits video to height by default' do
      @target = shell
      @target.content {
        @video = video(file: video_file) {
          on_completed {
            expect(@video.swt_widget.evaluate("return document.getElementById('video').height")).to eq(100.0)
          }
        }
      }
    end

    it 'does not fit video to height when specified with fit_to_height option argument' do
      @target = shell
      @target.content {
        @video = video(file: video_file, fit_to_height: false) {
          on_completed {
            expect(@video.swt_widget.evaluate("return document.getElementById('video').height")).to eq(0.0)
          }
        }
      }
    end

    it "autoplays video by default" do
      @target = shell
      @target.content {
        @video = video(file: video_file) {
          on_completed {
            expect(@video.swt_widget.evaluate("return document.getElementById('video').autoplay")).to eq(true)
          }
        }
      }
    end

    it "does not autoplay video when specified with autoplay option argument" do
      @target = shell
      @target.content {
        @video = video(file: video_file, autoplay: false) {
          on_completed {
            expect(@video.swt_widget.evaluate("return document.getElementById('video').autoplay")).to eq(false)
          }
        }
      }
    end

    it "plays/stops video manually" do
      @target = shell
      @target.content {
        alpha 0 # keep invisible while running specs
        @video = video(file: video_file, autoplay: false) {
          on_completed {
            @video.play
            expect(@video.swt_widget.evaluate("return document.getElementById('video').paused")).to eq(false)
            @video.pause
            expect(@video.swt_widget.evaluate("return document.getElementById('video').paused")).to eq(true)
            @target.dispose
          }
        }
      }
      @target.open
    end

    it 'sets offset_x to 0 by default' do
      @target = shell
      @target.content {
        @video = video(file: video_file) {
          on_completed {
            expect(@video.swt_widget.evaluate("return document.getElementById('style-body-offset-x').innerHTML")).to include("margin-left: 0px;")
          }
        }
      }
    end

    it 'sets offset_x to value specified by offset_x option argument' do
      @target = shell
      @target.content {
        @video = video(file: video_file, offset_x: -150) {
          on_completed {
            expect(@video.swt_widget.evaluate("return document.getElementById('style-body-offset-x').innerHTML")).to include("margin-left: -150px;")
          }
        }
      }
    end

    it 'sets offset_y to 0 by default' do
      @target = shell
      @target.content {
        @video = video(file: video_file) {
          on_completed {
            expect(@video.swt_widget.evaluate("return document.getElementById('style-body-offset-y').innerHTML")).to include("margin-top: 0px;")
          }
        }
      }
    end

    it 'sets offset_y to value specified by offset_y option argument' do
      @target = shell
      @target.content {
        @video = video(file: video_file, offset_y: -150) {
          on_completed {
            expect(@video.swt_widget.evaluate("return document.getElementById('style-body-offset-y').innerHTML")).to include("margin-top: -150px;")
          }
        }
      }
    end

    it 'plays and pauses video' do
      @target = shell
      @target.content {
        @video = video(file: video_file, autoplay: false) {
          on_completed {
            expect(@video.swt_widget.evaluate("return document.getElementById('video').paused")).to eq(true)
            @video.play
            expect(@video.swt_widget.evaluate("return document.getElementById('video').paused")).to eq(false)
            @video.pause
            expect(@video.swt_widget.evaluate("return document.getElementById('video').paused")).to eq(true)
          }
        }
      }
    end
  end
end