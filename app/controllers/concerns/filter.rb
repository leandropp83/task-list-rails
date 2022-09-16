module Filter
    
    protected

    def current_page
        (params[:page] || 1)
    end

    def order
        order = ( ORDER_BY.include? params[:order_by].to_s ) ? params[:order_by].to_s : "1"
        ORDER_BY[order][:value]
    end
end

