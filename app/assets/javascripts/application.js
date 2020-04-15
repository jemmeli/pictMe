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
//= require jquery2
//= require jquery_ujs
//= require jquery.remotipart
//= require retina.js
//= require s3_direct_upload
//= require bootstrap-sprockets
//= require bootstrap-switch
//= require_tree .


$(function () {

	$(document).on('click', '#results_table th a', function(){
		$.getScript(this.href);
    return false;
	});
	$(document).on('keyup', '#results_search input', function(){
		$.get($('#results_search').attr('action'), $('#results_search').serialize(), null, 'script');
	});
    $('.bootstrap-switch').bootstrapSwitch();

    //Import CSV
    $("#selectedFileCsv").on('change',function () {
        //$("#importCsvModal").modal('show');
        //read this
        //https://www.sitepoint.com/guide-ruby-csv-library-part/
    });

    //Process
    $(".someClass").on('click', function(){
        //document.getElementById('processCsv').click();
        //document.getElementById('selectedFileCsv').click();
        $("#importCsvModal").modal('show');
    });

    //process csv send form.uploadCsv directly after choose the file

    $("#selectedFileProcessCsv").on('change',function () {
        setTimeout(function(){
            console.log("selectedFileProcessCsv");
            $("form.processCsv").submit();
        }, 1000);


    });

    $(".processCsv").bind("ajax:success", function(){
        firstRowarr = [];
        gon.firstRowCsv.map(row => firstRowarr[row[0]] = row[1] );
        console.log( firstRowarr  );
        //show the first row in the CSV
        $("#telFirst").html( firstRowarr["Telephone"] );
        $("#emailFirst").html( firstRowarr["Email"] );
        $("#dossardFirst").html( firstRowarr["Doss"] );
        $("#nomFirst").html( firstRowarr["Nom"] );
        $("#prenomFirst").html( firstRowarr["Prenom"] );

        $("#importCsvModal").modal('show');

    });


});
