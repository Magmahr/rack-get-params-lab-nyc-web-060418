class Application

  @@cart = []
  @@items = ["Apples","Carrots","Pears","Figs"]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
        @@cart << item
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
        if @@cart.length == 0
          resp.write "Your cart is empty"
        else
          @@cart.each do |item|
          resp.write "#{item}\n"
          end
        end
    elsif req.path.match(/add/)
      add_item = req.params["item"]
      unless @@items.include?(add_item)
        # resp.write "#{search_term} is one of our items"
        resp.write "We don't have that item"
      else @@items.include?(add_item)
        @@cart << add_item
        resp.write "added #{add_item}"
      end
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
