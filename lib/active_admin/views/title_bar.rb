module ActiveAdmin
  module Views
    class TitleBar < Component

      def build(title, action_items)
        super(id: "title_bar", class: 'title-bar')
        @title = title
        @action_items = action_items
        build_titlebar_left
        build_titlebar_right
      end

      private

      def build_titlebar_left
        div id: "titlebar_left", class: 'title-bar-header' do
          build_breadcrumb
          build_title_tag
        end
      end

      def build_titlebar_right
        div id: "titlebar_right", class: 'title-bar-actions' do
          build_action_items
        end
      end

      def build_breadcrumb(separator = "/")
        breadcrumb_config = active_admin_config && active_admin_config.breadcrumb

        links = if breadcrumb_config.is_a?(Proc)
          instance_exec(controller, &active_admin_config.breadcrumb)
        elsif breadcrumb_config.present?
          breadcrumb_links
        end
        return unless links.present? && links.is_a?(::Array)
        ol class: "breadcrumb" do
          links.each do |link|
            li do
              text_node link
            end
          end
        end
      end

      def build_title_tag
        h2(@title, id: 'page_title', class: 'title-bar-heading')
      end

      def build_action_items
        insert_tag(view_factory.action_items, @action_items) if @action_items.any?
      end

    end
  end
end
