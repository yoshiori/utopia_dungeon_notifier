require "utopia_dungeon_notifier"

require "summons_board"
require 'thor'
require "im-kayac"
require "pushover"

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
      text = "今日のユートピアダンジョンは "
      event.schedule[:times].each do |active_time|
        text << "#{active_time.first.strftime("%H")}時 "
      end
      im_kyac.post(text)
    end

    desc "check \${uid} \${user_token} \${app_token}", "check event."
    def checkpo(uid, user_token, app_token)
      event = SummonsBoard::Event.new(uid: uid)
      if event.active?
        Pushover.notification(message: 'ユートピアダンジョンスタート', title: 'サモンズボード', user: user_token, token: app_token)
      end
    end

    desc "schedule \${uid} \${user_token} \${app_token}", "send event schedule."
    def schedulepo(uid, user_token, app_token)
      event = SummonsBoard::Event.new(uid: uid)
      text = "今日のユートピアダンジョンは "
      event.schedule[:times].each do |active_time|
        text << "#{active_time.first.strftime("%H")}時 "
      end
      Pushover.notification(message: text, title: 'サモンズボード', user: user_token, token: app_token)
    end

    private
    def im_kyac
      @im_kayac ||= ImKayac.to(@user_name).secret(@secret_key)
    end
  end
end
