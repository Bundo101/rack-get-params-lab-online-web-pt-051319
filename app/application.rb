class Application

  @@items = ["Apples","Carrots","Pears"]

  @@cart = []
  
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      unless @@cart.empty?
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      else 
        resp.write "Your cart is empty"
      end
    elsif req.path.match(/add/)
      item_to_add = req.params["item"]
      unless @@items.include?(item_to_add)
        resp.write "We don't have that item"
      else
        @@cart << item_to_add
        resp.write "added #{item_to_add}"
      end
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end
  
  #search_term = req.params["q"]

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end