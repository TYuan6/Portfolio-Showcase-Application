class Video < ActiveRecord::Base
  YT_LINK_FORMAT = /\A.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/i
  OTHER_LINK_FORMAT=/\A(http:\/\/|https:\/\/)?(www.)?(\S)+(.mp4|.3gp|.ogv|.webm|.flv|.ogg)\z/i

   validates_presence_of :title
   validates_uniqueness_of :link, scope: :proj_id
   belongs_to :proj
   
  before_create -> do
    uid = link.match(YT_LINK_FORMAT)
    k = link.match(OTHER_LINK_FORMAT)
    if uid && uid[2]
      self.uid = uid[2]
      if self.uid.to_s.length != 11
        self.errors.add(:link, 'is an invalid youtube link.')
        false
      end
    elsif k.nil?
      self.errors.add(:link, 'is an invalid web video link.')
      false
    end
  end

  before_update -> do 
    uid = link.match(YT_LINK_FORMAT)
    k = link.match(OTHER_LINK_FORMAT)
    if uid && uid[2]
      self.uid = uid[2]
      if self.uid.to_s.length != 11
        self.errors.add(:link, 'is an invalid youtube link.')
        false
      end
    elsif k.nil?
      self.errors.add(:link, 'is an invalid web video link.')
      false
    end
  end

# private

# def get_additional_info
#   begin
#     client = YouTubeIt::OAuth2Client.new(dev_key: 'AIzaSyACPr4hvXVbsjkroEZndKNK9ynl3SYHqQM')
#     #video = client.video_by(uid)
#     # self.title = video.title
#     # self.duration = parse_duration(video.duration)
#     # self.author = video.author.name
#     # self.likes = video.rating.likes
#     # self.dislikes = video.rating.dislikes
#   # rescue
#     # self.title = '' ; self.duration = '00:00:00' ; self.author = '' ; self.likes = 0 ; self.dislikes = 0
#   end
# end

end
