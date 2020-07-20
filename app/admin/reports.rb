# frozen_string_literal: true

ActiveAdmin.register_page 'Reports' do
  menu priority: 4

  page_action :top_10_report, method: :get do
    @customers = TopTenCustomersQuery.new.all
    render admin_reports_top_10_report_path
  end

  action_item :add do
    link_to 'Make top 10 report', admin_reports_top_10_report_path, method: :get
  end
end
