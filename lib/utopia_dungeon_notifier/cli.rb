require "utopia_dungeon_notifier"

require "summons_board"
require 'thor'
require "pit"
require "im-kayac"

module UtopiaDungeonNotifier
  class CLI < Thor
    desc "check \${uid}", "check event."
    def check(uid)
      event = SummonsBoard::Event.new(uid: uid)
      if event.active?
        im_kyac.post('ユートピアダンジョンスタート')
      end
    end

    desc "schedule \${uid}", "send event schedule."
    def schedule(uid)
      event = SummonsBoard::Event.new(uid: uid)
      text = "今日のユートピアダンジョンは "
      event.schedule[:times].each do |active_time|
        text << "#{active_time.first.strftime("%H")}時 "
      end
      im_kyac.post(text)
    end

    private
    def im_kyac
      @im_kayac ||= ImKayac.to(pit["username"]).password(pit["password"])
    end

    def pit
      @pit ||= Pit.get('im.kayac.com')
    end
  end
end
