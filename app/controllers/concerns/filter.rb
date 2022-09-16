module Filter
    protected

    def current_page
        (params[:page] || 1)
    end

    def order
        (params[:order_by] && ORDER_BY[params[:order_by].to_i] ? ORDER_BY[params[:order_by].to_i] : ORDER_BY[0])
    end
end