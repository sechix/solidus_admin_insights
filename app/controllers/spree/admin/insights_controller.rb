module Spree
  module Admin
    class InsightsController < Spree::Admin::BaseController
      before_action :ensure_report_exists, :set_default_pagination, only: [:show, :download]
      before_action :set_reporting_period, only: [:index, :show, :download]
      before_action :load_reports, only: [:index, :show]

      def index
        respond_to do |format|
          format.html
          format.json { render json: {} }
        end
      end

      def show
        report = ReportGenerationService.generate_report(@report_name, params.merge(@pagination_hash))

        @report_data = shared_data.merge(report.to_h)
        respond_to do |format|
          format.html { render :index }
          format.json { render json: @report_data }
        end
      end

      def download
        @report = ReportGenerationService.generate_report(@report_name, params.merge(@pagination_hash))

        respond_to do |format|
          format.csv do
            send_data ReportGenerationService.download(@report),
              filename: "#{ @report_name.to_s }.csv"
          end
          format.xls do
            send_data ReportGenerationService.download(@report, { col_sep: "\t" }),
              filename: "#{ @report_name.to_s }.xls"
          end
          format.text do
            send_data ReportGenerationService.download(@report),
              filename: "#{ @report_name.to_s }.txt"
          end
          format.pdf do
            render pdf: "#{ @report_name.to_s }",
              disposition: 'attachment',
              layout: 'spree/layouts/pdf.html'
          end
        end
      end

      private
        def ensure_report_exists
          @report_name = params[:id].to_sym
          unless ReportGenerationService.report_exists?(get_report_category, @report_name)
            redirect_to admin_insights_path, alert: Spree.t(:not_found, scope: [:reports])
          end
        end

        def load_reports
          @reports = ReportGenerationService.reports_for_category(get_report_category)
        end

        def shared_data
          {
            current_page:      params[:page] || 0,
            report_category:   params[:report_category],
            request_path:      request.path,
            url:               request.url,
            searched_fields:   params[:search],
          }
        end

        def get_report_category
          params[:report_category] = if params[:report_category]
            params[:report_category].to_sym
          else
            session[:report_category].try(:to_sym) || ReportGenerationService.default_report_category
          end
          session[:report_category] = params[:report_category]
        end

        def set_reporting_period
          if params[:search].present?
            params[:search][:start_date] = params[:search][:start_date].presence || session[:search_start_date]
            params[:search][:end_date] = params[:search][:end_date].presence || session[:search_end_date]
          else
            params[:search] = {}
            params[:search][:start_date] = session[:search_start_date]
            params[:search][:end_date] = session[:search_end_date]
          end
          session[:search_start_date] = params[:search][:start_date]
          session[:search_end_date] = params[:search][:end_date]
        end

        def set_default_pagination
          @pagination_hash = { paginate: false }
          unless params[:paginate] == 'false'
            @pagination_hash[:paginate] = true
            @pagination_hash[:records_per_page] = params[:per_page].try(:to_i) || Spree::Config[:records_per_page]
            @pagination_hash[:offset] = params[:page].to_i * @pagination_hash[:records_per_page]
          end
        end
    end
  end
end
