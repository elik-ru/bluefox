// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require turbolinks
//= require jquery.turbolinks
//= require bootstrap
//= require twitter/typeahead
//= require bootstrap-wysihtml5
//= require bootstrap-wysihtml5/locales/ru-RU
//= require_tree .


$(function(){
  $('.datepicker').datepicker({ dateFormat: "dd.mm.yy" ,firstDay: 1});
  $('.wysihtml5').each(function(i, elem) {
    $(elem).wysihtml5();
  });
  
  $('.ability_select').each(function(index){
    var abilities = new Bloodhound({
      datumTokenizer: Bloodhound.tokenizers.obj.whitespace('name'),
      queryTokenizer: Bloodhound.tokenizers.whitespace,
      prefetch: {
        url: '/abilities.json?'+Math.random(),
        filter: function(list) {
          return $.map(list, function(ab) {
            return { name: ab.name }; });
        }
      }
    });
    abilities.initialize();

    $(this).tagsinput({
      confirmKeys: [9, 10, 13, 44, 188],
      typeaheadjs: {
        name: 'abilities',
        displayKey: 'name',
        valueKey: 'name',
        source: abilities.ttAdapter()
      }
    });
  })
  
})
