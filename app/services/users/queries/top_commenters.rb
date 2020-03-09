module Users
  module Queries
    class TopCommenters
      def initialize(user_repo: User)
        @user_repo = user_repo
      end

      def self.call
        new.call
      end

      def call
        @user_repo.select('users.*, COUNT(comments.user_id) AS comments_count')
                  .left_outer_joins(:comments)
                  .merge(Comment.where(created_at: (Time.current - 7.days)..Time.current))
                  .group('users.id')
                  .order('comments_count DESC')
                  .limit(10)
      end
    end
  end
end
