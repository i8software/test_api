class Reaction < ApplicationRecord
  belongs_to :reactor, class_name: 'User'
  belongs_to :reacted_on, polymorphic: true

  after_create ->(_obj) { update_reaction_counter('add') }
  after_update ->(_obj) { update_reaction_counter('add') }
  after_destroy ->(_obj) { update_reaction_counter('delete') }

  enum reaction: { like: 1, unlike: -1 }

  private

  def update_reaction_counter(action)
    unless action == 'delete'
      if self.reaction == 'like'
        self.reactor.likes_count = self.reactor.likes_count + 1
        self.reactor.save!
        self.reacted_on.likes_count = self.reacted_on.likes_count + 1
        self.reacted_on.save!
        if action == 'update'
          self.reactor.unlikes_count = self.reactor.unlikes_count - 1
          self.reactor.save!
          self.reacted_on.unlikes_count = self.reacted_on.unlikes_count - 1
          self.reacted_on.save!
        end
      else
        self.reactor.unlikes_count = self.reactor.unlikes_count + 1
        self.reactor.save!
        self.reacted_on.unlikes_count = self.reacted_on.unlikes_count + 1
        self.reacted_on.save!
        if action == 'update'
          self.reactor.likes_count = self.reactor.likes_count - 1
          self.reactor.save!
          self.reacted_on.likes_count = self.reacted_on.likes_count - 1
          self.reacted_on.save!
        end
      end
      return
    end
    if self.reaction == 'like'
      self.reactor.likes_count = self.reactor.likes_count - 1
      self.reactor.save!
      self.reacted_on.likes_count = self.reacted_on.likes_count - 1
      self.reacted_on.save!
    else
      self.reactor.unlikes_count = self.reactor.unlikes_count - 1
      self.reactor.save!
      self.reacted_on.unlikes_count = self.reacted_on.unlikes_count - 1
      self.reacted_on.save!
    end
  end
end
