class Post < ActiveRecord::Base
  
  validates_presence_of :title
  validates_tiny_mce_presence_of :detail
  
  belongs_to :user
  has_many :comments, :order => 'created_at', :dependent => :destroy
  has_many :categorizations
  has_many :tags, :through => :categorizations, :uniq => true
  
  named_scope :sorted_by_created_at, lambda { { :order => "created_at DESC" }}
  named_scope :sorted_by_updated_at, lambda { { :order => "updated_at DESC" }}
  named_scope :featured, lambda { { :conditions => [ "featured_at IS NOT NULL" ], :order => "featured_at DESC", :limit => 6 }} 
  named_scope :limit_to, lambda { | limit | { :limit => limit } }
  
  alias_attribute :to_s, :title
  
  def brief
    truncate(HTML::FullSanitizer.new.sanitize(detail), 500)
  end
  
  def featured?
    !featured_at.nil?
  end

  private
    def truncate(text, length)
      truncate_string = "..."
      l = length - truncate_string.chars.length
      (text.chars.length > length ? text.chars[0...l] + truncate_string : text).to_s
    end
  
  
end
