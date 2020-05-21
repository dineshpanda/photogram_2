class NotFoundController < ApplicationController
  def builder
    builder_url = "https://builder.io/api/v1/html/page?url=#{request.original_url}&apiKey=#{ENV.fetch("BUILDER_API_KEY")}"

    builder_response = HTTParty.get(builder_url, follow_redirects: true)

    if builder_response.code != 404
      data = JSON.parse(builder_response.body).fetch("data")
      @content = data.fetch("html").html_safe
    else
      render :not_found, status: 404, layout: false
    end
  end
end
