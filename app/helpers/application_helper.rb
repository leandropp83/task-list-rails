module ApplicationHelper

    def progress(progress, legend = nil)
        str = ''
        unless legend.nil?
            str +=
            '<div class="row justify-content-end align-items-center">'
        end
            str += 
            '<div class="progress w-100 px-0">
                <div class="progress-bar" role="progressbar" style="width:' + progress.to_s + '%;" aria-volumenow="' + progress.to_s + '" aria-volumemin="0" aria-volumemax="100">
                    ' + progress.to_s + '%
                </div>
            </div>'
        unless legend.nil?
            str +=
                '<div class="col-auto">
                        <p class="mb-0">' + legend.to_s + '</p>
                </div>
            </div>'
        end        
        str.html_safe
    end

    def will_paginate(coll_or_options = nil, options = {})
        if coll_or_options.is_a? Hash
            options = coll_or_options
            coll_or_options = nil
        end
        unless options[:renderer]
            options = options.merge renderer: BootstrapPaginateRenderer
        end
        super *[coll_or_options, options].compact
    end

    def get_order
        ( ORDER_BY.include? params[:order_by].to_s ) ? params[:order_by].to_s : "1"
    end

end
