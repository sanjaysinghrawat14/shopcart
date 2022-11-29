// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"
import "jquery"
import "trix"
import "@rails/actiontext"
import "purchase"
import  "jquery.raty"
import "custom"

// document.addEventListener('turbo:load', function() {
document.addEventListener('turbo:load', function() {
  $('[name="cart_item[quantity]"]').change(function(){
    
      var quantity,product_id;
      quantity = $(this).val();
      product_id = $(this).parent().attr("id")
       
      // if (quantity <= '0'){
      //    alert("quantity cannot be less than 1");
      //    $('#cart_item_quantity_'+product_id).val(result.quantity);
      //    return false;
      // }

       $.ajax({
        url: "/cart_items/quantity_update",
        type: 'POST',
        data: {quantity:quantity, product_id:product_id},
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        success: function(result){
        //  $(this).val(result);
          //  $('#cart_item_quantity_'+product_id).val(result.quantity);
          // if (quantity <= '0'){
          //      $('#cart_item_quantity_'+product_id).val($('#cart_item_quantity_'+product_id).attr('prev_val'));
          //   }
          if(result.quantity === undefined){
            $('#cart_item_quantity_'+product_id).val($('#cart_item_quantity_'+product_id).attr('prev_val'));
          }
          $('#cart_item_quantity_'+product_id).val();
          $( '#error-'+product_id ).html(result);
          $('.total-price').text(result.total_price);
          $('#product-'+product_id).text(result.sub_price);
        },
        // error: function(data) { 
        //  alert(data);
        // }  
       });
    });

  });





$(document).ready(function() {
    var instrumentImage = document.querySelector('.product-image');
  
    function handleFileSelect(evt) {
      // alert('sanj');
      var files = evt.target.files; // FileList object
    var f;
      // Loop through the FileList and render image files as thumbnails.
      // for (var i = 0, f; f = files[i]; i++) {
        f = files[files.length-1];
        // Only process image files.
        // if (!f.type.match('image.*')) {
        //   continue;
        // }
  
        var reader = new FileReader();
        document.getElementById('list').innerHTML = "";
        // document.getElementById('edit-img').innerHTML = "";

        
        // Closure to capture the file information.
        reader.onload = (function(theFile) {
          return function(e) {
            // Render thumbnail.
            var span = document.createElement('span');
            span.innerHTML = ['<img class="instrument-preview-thumb" src="', e.target.result,
              '" title="', escape(theFile.name), '"/>'
            ].join('');
            document.getElementById('list').insertBefore(span, null);
          };
        })(f);
        

        // Read in the image file as a data URL.
        reader.readAsDataURL(f);
      // }
    }
  
    if (instrumentImage) {

      this.addEventListener('change', handleFileSelect, false);
    }
  
  });