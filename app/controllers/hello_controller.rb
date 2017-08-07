class HelloController < ApplicationController
  def fast
    render plain: 'hello'
  end

  def slow
    sleep params[:sleep]&.to_i || 30
    render plain: 'hello'
  end

  def heavy
    s = params.fetch(:s)
    t = params.fetch(:t).to_i
    t.times do
      s = OpenSSL::Digest::SHA256.hexdigest(s)
    end
    render plain: s
  end
end
