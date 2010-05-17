class WikiMembership < ActiveRecord::Base
  
  validates_presence_of :user, :wiki
  validates_uniqueness_of :user_id, :scope => :wiki_id #can't be a member in the same wiki twice
  
  belongs_to :user
  belongs_to :wiki
  
  named_scope :active, :conditions => ["active = ?", true]
  named_scope :inactive, :conditions => ["active = ?", false]  
  
  after_create :send_membership_invivation
  
  def can_be_removed_by?(a_user)
    wiki.is_not_owned_by?(user) && (wiki.is_owned_by?(a_user) || user.eql?(a_user))
  end
  
  def activate
    self.active = true
    self.save
  end
  
  def deactivate
    self.active = false
    self.save
  end
  
  def send_membership_invivation
    unless self.active?
      WikiNotifier.deliver_membership_invitation(self)
    end
  end
  
end