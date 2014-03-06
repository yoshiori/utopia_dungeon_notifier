require "utopia_dungeon_notifier"

require "summons_board"
require 'thor'
require "im-kayac"

module UtopiaDungeonNotifier
  class CLI < Thor
    desc "check \${uid} \${imKayac_UserName} \${imKayac_SecretKey}", "check event."
    def check(uid, user_name, secret_key)
      @user_name = user_name
      @secret_key = secret_key
      event = SummonsBoard::Event.new(uid: uid)
      if event.active?
        im_kyac.post('ユートピアダンジョンスタート')
      end
    end

    desc "schedule \${uid} \${imKayac_UserName} \${imKayac_SecretKey}", "send event schedule."
    def schedule(uid, user_name, secret_key)
      @user_name = user_name
      @secret_key = secret_key
      event = SummonsBoard::Event.new(uid: uid)
      schedule = event.schedule
      text = "ユートピアダンジョン [#{schedule[:attribute]}]\n\t"
      schedule[:times].each do |active_time|
        text << "#{active_time.first.strftime("%H")}時 "
      end
      text << "\nイベントダンジョン #{schedule[:weekly]}"
      im_kyac.handler('http://sb.gungho.jp/member/info/articleinfo001_3iam.html').post(text)
    end

    private
    def im_kyac
      @im_kayac ||= ImKayac.to(@user_name).secret(@secret_key)
    end
  end
end
