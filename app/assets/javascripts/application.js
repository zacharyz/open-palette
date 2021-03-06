// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//                                                            
//= require jquery
//= require jquery_ujs         
//= require jquery.masonry
//= require jquery.imagesloaded                            
//= require bootstrap-twipsy
//= require bootstrap-scrollspy
//= require bootstrap-modal
//= require bootstrap-dropdown
//= require bootstrap-alerts
//= require bootstrap-tabs
//= require bootstrap-popover
//= require_self


function error(msg) {
 var s = document.querySelector('#status');
 s.innerHTML = typeof msg == 'string' ? msg : "failed";
 s.className = 'fail';

 // console.log(arguments);
}

$(function(){        
  $('.main .posts').imagesLoaded(function(){
    $('.main .posts').masonry({
      itemSelector : '.post',
      columnWidth : 240
    });
  });  
  $('.sidebar .posts').imagesLoaded(function(){
    $('.sidebar .posts').masonry({
      itemSelector : '.post',
      columnWidth : 40
    });
  });  
  $('.post').popover({
    offset: 0,
	html: true,
	animate: true,
	placement: 'right'
  }) 
  $('.user').twipsy({
    live: true,
	placement: 'right',
	offset: 0  
  })
  $("a[rel=twipsy]").twipsy({
    live: true,
	placement: 'below',
	offset: 5  
  })
});                           




