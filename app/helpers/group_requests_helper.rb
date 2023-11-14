module GroupRequestsHelper
    def format_request_status(status)
      case status
      when 'pending'
        'Pending Approval'
      when 'approved'
        'Approved'
      else
        'Unknown Status'
      end
    end
  end
