class StarsRenderer
    def initialize(rating, template)
      @rating = rating
      @template = template
    end
    
    def render_stars
      content_tag :div, star_images, :class => 'stars'
    end
  
    private
    
    def star_images
      (0...5).map do |position|
        star_image(((5)*2).round)

        # star_image(((@ratingposition)*2).round)
      end.join
    end
    
    
    # def star_image(value)
    #   image_tag "/images/#{star_type(value)}_star.gif", :size => '15x15'
    # end
    
    def star_image(value)    
        image_tag "#{star_type(value)}.png", :size => '15x15'  
      end  



    def star_type(value)
      if value <= 0
        'empty'
      elsif value == 1
        'half'
      else
        'full'
      end
    end
    
    def method_missing(*args, &block)
      @template.send(*args, &block)
    end
  end