# frozen_string_literal: true

ActiveAdmin.register_page 'Reports' do
  menu priority: 4

  content title: 'Reports' do
    div class: 'blank_slate_container', id: 'dashboard_default_message' do
      span class: 'blank_slate' do
        # span I18n.t('active_admin.dashboard_welcome.welcome')
        # small I18n.t('active_admin.dashboard_welcome.call_to_action')
      end
    end
  end

  page_action :top_10_report, method: :post do
    @customers = TopTenCustomersQuery.new(params['report_top_10']).top_10
    render admin_reports_top_10_report_path
  end

  sidebar :index do
    render partial: 'admin/reports/form'
  end
end
