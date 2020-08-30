var app = angular.module("myApp", []);

app.factory( 'dataService',function($http,$q) {
    return{
        getAllContacts: getAllContacts,
        getAllCampaigns: getAllCampaigns,
        getAllPictures: getAllPictures,
        deletePicture: deletePicture
    };

    //get all Contacts
    function getAllContacts( id ){
        var ID = $(this).attr("data-edition");
        console.log(ID);
      
        //abstract the call of https call
        return $http({
            method: 'GET',
            url: '/api/v1/editions/'+id+'/contacts'
        })
        .then( sendResponseData )
        .catch( sendGetContactsError );
    
    }

    function sendResponseData( reponse ){
        return reponse.data;
    }
    
    function sendGetContactsError( reponse ){
        return $q.reject('Error retreiving contacts(s). (HTTP status: ' + reponse.id + ')' );
    } 

    //get all Campaigns
    function getAllCampaigns( id ){
        var ID = $(this).attr("data-edition");
        console.log(ID);
      
        //abstract the call of https call
        return $http({
            method: 'GET',
            url: '/api/v1/editions/'+id+'/getCampaigns'
        })
        .then( sendResponseCampaignsData )
        .catch( sendGetCampaignsError );
    
    }
    function sendResponseCampaignsData( reponse ){
        return reponse.data;
    }
    
    function sendGetCampaignsError( reponse ){
        return $q.reject('Error retreiving Campaigns(s). (HTTP status: ' + reponse + ')' );
    } 

    //get all pictures
    function getAllPictures( event_id, id ){
        /* var ID = $(this).attr("data-edition");
        console.log(ID); */
      
        //abstract the call of https call
        return $http({
            method: 'GET',
            url: '/api/v1/events/'+event_id+'/editions/'+id+'/pictures'
        })
        .then( sendResponsePicturesData )
        .catch( sendGetPicturesError );
    
    }
    function sendResponsePicturesData( reponse ){
        return reponse.data;
    }
    
    function sendGetPicturesError( reponse ){
        return $q.reject('Error retreiving Pictures(s). (HTTP status: ' + reponse + ')' );
    } 

    //deletePicture
    function deletePicture( event_id, edition_id, pictureID ){
      
        return $http({
            method: 'DELETE',
            url : '/api/v1/events/'+event_id+'/editions/'+edition_id+'/pictures/' + pictureID
                   
        })
            .then( deletePictureSuccess )
            .catch( deletePictureError );

    }
    function deletePictureSuccess( response ){
        return 'picture deleted';
    }
    
    function deletePictureError( reponse ){
        return $q.reject('Error deleting picture(s). (HTTP status: ' + response.status + ')' );
    }
    
    
    

} )

app.controller("mainCtrl", function( dataService, $scope ){

    var vm = this;
    theID = null;
    vm.length = 0;
    vm.lengthCampaigns = 0;
    vm.perPageArr = [3, 5, 10, 20, 50];
    vm.curentPage = 1;
    vm.perPage = vm.perPage | 5 ;
    vm.numberPaginationArr = [];
    vm.numberPaginationCampaignsArr = [];

    vm.campaign = null;
    vm.email = null;
    //$scope.ids = [];

    vm.firstStep = true;
    vm.secondStep = false;
    vm.thirdStep = false;

    //Campains
    vm.allCampaigns = null; 

    /*=======================
    ===get contacts details per campaign==
    =========================*/
    vm.showContactsDetails = function( campaignId ){
        console.log( campaignId );
    }
    

    
    /*===============================
    =============Contacts=============
    =================================*/

    function getContactsSuccess( contacts ){
        vm.allContacts = contacts;
        console.log( vm.allContacts );
        vm.length = contacts.length;
        calculatePagination();
    }
    function getContactsError( errorMsg ){
        console.log('Error Message: ' + errorMsg );
    }

    function getCampaignsSuccess( campaigns ){
        vm.allCampaigns = campaigns;
        console.log( vm.allCampaigns );
        vm.lengthCampaigns = campaigns.length;
        calculatePaginationCampaign();
    }
    function getCampaignsError( errorMsg ){
        console.log('Error Message: ' + errorMsg );
    }

    vm.isUndefined = function (thing) {
        return (typeof thing === "undefined");
    }

    vm.getCurrentPage = function( id ){
        event.stopPropagation();
        vm.curentPage = id;
        //pagination
        calculatePagination();
        calculatePaginationCampaign();

    }

    //navigation events
    navigation = function( mode ){
        switch (mode) {
            case 'prev':
                if( vm.curentPage > 1 ){ vm.curentPage =  vm.curentPage - 1; }
                break;
            case 'next':
                if( vm.curentPage < vm.numberPagination ){ vm.curentPage =  vm.curentPage + 1; }
                break;
            case 'prevCampaign':
                if( vm.curentPage > 1 ){ vm.curentPage =  vm.curentPage - 1; }
                break;
            case 'nextCampaign':
                if( vm.curentPage < vm.numberCampaignPagination ){ vm.curentPage =  vm.curentPage + 1; }
                break;
            
        }

    }

    vm.previousContacts = function(){
        navigation('prev');
        calculatePagination();
    }
    vm.nextContacts = function(){
        navigation('next');
        calculatePagination();
    }
    //
    vm.previousCampaign = function(){
        navigation('prevCampaign');
        calculatePaginationCampaign();
    }
    vm.nextCampaign = function(){
        navigation('nextCampaign');
        calculatePaginationCampaign('nextCampaign');
    }

    

    /*===============================
    =============Campaign=============
    =================================*/

    vm.filterCampaign = [
        {id: 1, name: "contact avec Photo" },
        {id: 2, name: "Course de Bayonne" },
        {id: 3, name: "a déjà acheté" },
        {id: 4, name: "contacté" }
    ];
    vm.selectedfilterCampaign =  vm.filterCampaign[0];
    $scope.selectedEmails = [];

    vm.exist =  function( item ){
        return $scope.selectedEmails.indexOf( item ) > -1;
    }

    vm.toggleSelection = function( item ){
        var idx = $scope.selectedEmails.indexOf( item );
        if( idx > -1 ){
            $scope.selectedEmails.splice(idx, 1);
        }else{
            $scope.selectedEmails.push( item );
        }
    }

    vm.onSelected = function(){
        console.log( $scope.selectedEmails );
    }

    vm.checkAll = function(){
        if( !vm.selectAll ){
            angular.forEach( vm.allContacts, function( item ){
                idx = $scope.selectedEmails.indexOf( item );
                if(idx >= 0 ){
                    return true;
                }else{
                    $scope.selectedEmails.push( item );
                }
            } )
        }else{
            $scope.selectedEmails = [];
        }
    }

    vm.goFirstStep = function(){
        vm.firstStep = true;
        vm.secondStep = false;
        vm.thirdStep = false;
    }

    //show modal 2nd step
    vm.goSecondStep = function(){
        vm.firstStep = false;
        vm.secondStep = true;
        vm.thirdStep = false;
    }

    //show modal 2nd step
    vm.goThirdStep = function(){
        vm.firstStep = false;
        vm.secondStep = false;
        vm.thirdStep = true;
    }

    //show modal 3third step previsualisation
    $("body").on('click', '#importerCampaign', function(){
        $("#secondStepCampaign").modal('hide');
        $("#thirdStepCampaign").modal('show');
        vm.goSecondStep(); 
    });

    $("body").on('click', '#visualCampaign', function(){
        $("#thirdStepCampaign").modal('hide');
        vm.goThirdStep();
    });

    vm.secondStepCampaignModal = function(){
        $("#secondStepCampaign").modal('show');
        $("#thirdStepCampaign").modal('hide');
        vm.goFirstStep();
    }

    




    //Watchers

    $scope.$watch("vm.id", function( newID ){
        if( newID ){
            theID = newID;
            //get all Contacts
            dataService.getAllContacts( theID )
                .then( getContactsSuccess, getContactsError );
            dataService.getAllCampaigns( theID )
                .then( getCampaignsSuccess, getCampaignsError );
            calculatePagination();
            calculatePaginationCampaign();
        }
    });

    $scope.$watch("vm.perPage", function(){
        vm.curentPage = 1;
        calculatePagination();
        calculatePaginationCampaign();
    });

    $scope.$watch("vm.curentPage", function( ){
        calculatePagination();
        calculatePaginationCampaign();
    });

    /* $scope.$watch("vm.allContacts", function( newAllContracts ){
        vm.allContacts = newAllContracts;
    }); */
    
    


    //Campaign Watchers
    $scope.$watch("vm.campaign", function( newCampaign ){
        if(newCampaign){
            vm.campaign = newCampaign;
            console.log(vm.campaign);
        }
    });

    /*======EVENTS======*/
    $scope.$on('currentPicture', function(event, currentPicture){
        console.log("===envent handler currentPicture===");
        console.log(currentPicture);
        console.log("===================================");
    });

    

    
    
    


    //private
    calculatePagination = function(){
        vm.numberPagination =  Math.ceil( vm.length / vm.perPage );
        vm.numberPaginationArr = [];
        for(i=0; vm.numberPagination > i ; i++){
            vm.numberPaginationArr.push( i );
        }
    }

    calculatePaginationCampaign = function(){
        vm.numberCampaignPagination =  Math.ceil( vm.lengthCampaigns / vm.perPage );
        vm.numberPaginationCampaignsArr = [];
        for(i=0; vm.numberCampaignPagination > i ; i++){
            vm.numberPaginationCampaignsArr.push( i );
        }
    }
    

    

    console.log( vm.firstStep );


});


app.controller("contactDetailsCtrl", function( $scope ){

    var vm = this

    theID = null;
    vm.length = 0;
    vm.lengthCampaigns = 0;
    vm.perPageArr = [1, 3, 5, 10, 20, 50];
    vm.curentPage = 1;
    vm.perPage = vm.perPage | 5 ;
    vm.numberPaginationArr = [];
    vm.numberPagination = 3;
    vm.deepCopy = vm.emailsArrays;

    //navigation events
    navigation = function( mode ){
        switch (mode) {
            case 'prev':
                if( vm.curentPage > 1 ){ vm.curentPage =  vm.curentPage - 1; }
                break;
            case 'next':
                if( vm.curentPage < vm.numberPagination ){ vm.curentPage =  vm.curentPage + 1; }
                break;
            
        }

    }

    vm.previousContacts = function(){
        navigation('prev');
        calculatePagination();
    }
    vm.nextContacts = function(){
        navigation('next');
        calculatePagination();
    }

    //
    $scope.$watch("vm.emailsArrays", function( newEmailsArrays ){
        if( newEmailsArrays ){
            vm.emailsArrays = newEmailsArrays;
            console.log( vm.emailsArrays );
            vm.length = vm.emailsArrays.length;
            calculatePagination();
            
        }
    });
    

    $scope.$watch("vm.perPage", function( newPerPage ){
        if( newPerPage ){
            vm.curentPage = 1;
            calculatePagination();
        }
        
    });

    

    //
    /* $scope.$watch("vm.numberPagination", function( newNumberPagination ){
        if( newNumberPagination ){
            vm.numberPagination = newNumberPagination;
        }
    }); */

    //private
    calculatePagination = function(){
        vm.numberPagination =  Math.ceil( vm.length / vm.perPage );
        console.log("vm.numberPagination : " + vm.numberPagination);
        console.log("vm.length : " + vm.length);
        console.log("vm.perPage : " + vm.perPage);
        vm.numberPaginationArr = [];
        for(i=0; vm.numberPagination > i ; i++){
            vm.numberPaginationArr.push( i );
        }
        //debugger
    }

});

//pictures
app.controller("modalPictureCtrl", function( dataService, $scope, $element, $attrs ){
    var vm = this;

    var thevalueid = $element.attr("thevalueid");
    var thevalueidevent = $element.attr("thevalueidevent");
    /* console.log( "-------------" );
    console.log( thevalueid );
    console.log( thevalueidevent );
    console.log( "-------------" ); */

    $scope.getObject =  function(obj){
        var myObj = JSON.parse( obj );
        var myID = myObj.id;
        return myID;
    }

    dataService.getAllPictures( thevalueidevent, thevalueid )
        .then( getPicturesSuccess, getPicturesError );

    function getPicturesSuccess( Pictures ){
        $scope.allPictures = Pictures;
    }
    function getPicturesError( errorMsg ){
        console.log('Error Message: ' + errorMsg );
    }

    vm.goNextImg = function(){
        vm.offset = $(".thumbnail .thumb").position().top;
        containerThumbTopPos = $(".thumbnail").position().top;
        if( vm.offset < containerThumbTopPos ){
            $(".thumbnail .thumb").css( "top", ( vm.offset + 180 ) );
        }else{
            return false;
        }

        /* firstThumbTopPosition = $(".thumbnail .thumb:first").position().top;
        console.log("firstThumbTopPosition : " + firstThumbTopPosition);
        lastThumbTopPosition = $(".thumbnail .thumb:last").position().top + 180;
        console.log("lastThumbTopPosition : " + lastThumbTopPosition); */
    }
    vm.goPrevImg = function(){
        vm.offset = $(".thumbnail .thumb").position().top;
        containerThumbBottomPos = $(".thumbnail").position().top + (180*4);
        lastThumbTopPosition = $(".thumbnail .thumb:last").position().top + 180;
        console.log(vm.offset);
        if( lastThumbTopPosition > containerThumbBottomPos ){
            $(".thumbnail .thumb").css( "top", ( vm.offset - 180 ) );
        }else{
            return false;
        }

        /* firstThumbTopPosition = $(".thumbnail .thumb:first").position().top;
        console.log("firstThumbTopPosition : " + firstThumbTopPosition);
        lastThumbTopPosition = $(".thumbnail .thumb:last").position().top + 180;
        console.log("lastThumbTopPosition : " + lastThumbTopPosition); */
    }
    

    vm.showCurrentPicture = function( currentPicture, currentIndex, $event){
        /*console.log( currentPicture );
        console.log( currentIndex ); 
        console.log( $element.find("div.thumbnail img") ); 
        currentImageClickedLink = $event.currentTarget.src;
        console.log( currentImageClickedLink );*/
        currentImageClickedLink = $event.currentTarget.src;
        $element.find("div.content img").attr("style", "display:none");
        $element.find("div.content img:nth-child("+currentIndex+")").removeAttr( "style" );
        $element.find("div.content img:nth-child("+currentIndex+")").attr( "src", currentImageClickedLink );
        let current_id_picture = document.getElementById("current_id_picture");
        let dossard = document.getElementById("dossard");
        //set id picture
        $("#btnDeletepicture").attr("data-picture-id", currentPicture.id );
        let theName = $("#theName");
        let theLastName = $("#theLastName");
        //if current owner exist
        if( currentPicture.id ){
            current_id_picture.value = currentPicture.id;
        }else{
            current_id_picture.value = "";
        }
        dossard.value = currentPicture.bib;

        if( currentPicture.owner_of_picture[0] ){
            console.log("owner existe 1");
            theName.html( currentPicture.owner_of_picture[0].nom );
            theLastName.html( currentPicture.owner_of_picture[0].prenom );
        }else{
            console.log("owner n'existe pas 1");
            theName.html( "pas de propriétaire" ).css("color", "#ef8e0c");
            theLastName.html( "pas de propriétaire" ).css("color", "#ef8e0c");
        }

        
    }


});


//pictures
app.controller("picturesDetailsCtrl", function( $scope ){

    var vm = this;
    vm.orderPictureArr = [{attr: 'Du récent au plus vieux' , val: 'created_at'}, {attr: 'Du vieux au plus récent' , val: '-created_at'}];

    $scope.$watch("allPictures", function( newPictures ){
        if( newPictures ){
            $scope.allPictures = newPictures;
        }   
    });

    $scope.getObject =  function(obj){
        var myObj = JSON.parse( obj );
        var myID = myObj.id;
        return myID;
    }

    //
    $scope.$watch("vm.orderPicture", function( newOrderPictures ){
        if( newOrderPictures ){
            vm.orderPicture = newOrderPictures;
        }   
    });

    
    

});

/*==============================================================================
===============================DIRECTIVES=======================================
===============================================================================*/

//pictures Directives
app.directive('picturesDirective', function(){
    return{
      restrict: "E",
      templateUrl: '/templates/pictures.html',
      link: function(scope, element, attrs){

      },
      controller: function(dataService, $scope, $element, $attrs){
        var vm = this;
        var thevalueid = $element.attr("thevalueid");
        var thevalueidevent = $element.attr("thevalueidevent");

        dataService.getAllPictures( thevalueidevent, thevalueid )
            .then( getPicturesSuccess, getPicturesError );

        function getPicturesSuccess( Pictures ){
            $scope.allPictures = Pictures;
        }
        function getPicturesError( errorMsg ){
            console.log('Error Message: ' + errorMsg );
        }

        $scope.getCurrentPictureInfo = function( currentPicture, $event ){
            currentImageClickedLink = $event.currentTarget.src;
            jQuery("#modalPictures").modal("show");
            $("#modalPictures").on('shown.bs.modal', function(){
                let content = document.getElementsByClassName("content")[0].children[0];
                jQuery(".content img").each(function( index ) {
                    jQuery( this ).attr('style', "display:none");
                });
                document.getElementsByClassName("content")[0].children[0].style = "";
                let current_id_picture = document.getElementById("current_id_picture");
                let dossard = document.getElementById("dossard");
                //set id picture
                $("#btnDeletepicture").attr("data-picture-id", currentPicture.id );
                let theName = $("#theName");
                let theLastName = $("#theLastName");
                //get the id of the owner
                if( currentPicture.id ){
                    current_id_picture.value = currentPicture.id;
                }else{
                    current_id_picture.value = "";
                }
                dossard.value = currentPicture.bib;
                content.src = currentImageClickedLink;
                if( currentPicture.owner_of_picture[0] ){
                    console.log("owner existe 1");
                    theName.html( currentPicture.owner_of_picture[0].nom );
                    theLastName.html( currentPicture.owner_of_picture[0].prenom );
                }else{
                    console.log("owner n'existe pas 1");
                    theName.html( "pas de propriétaire" ).css("color", "#ef8e0c");
                    theLastName.html( "pas de propriétaire" ).css("color", "#ef8e0c");
                }
                
                /*======EVENTS======*/
                $scope.$emit('currentPicture', currentPicture);
            });
            
        }

        $attrs.$observe('picturesDirective', function (newPictures) {
            if (newPictures) {
                // pass value to app controller
                $scope.allPictures = newPictures;
            }
        });  

      }
    }
 });


app.directive("modalHidden", function () {
    return{
        restrict : 'A',
        link : function(scope, element, attrs){
            $("#modalPictures").on('hidden.bs.modal', function(){
                jQuery(".content img").each(function( index ) {
                    jQuery( this ).attr('style', "display:none");
                });
                document.getElementsByClassName("content")[0].children[0].style = "";
            });
        }
    }
});

app.directive("deletePicture", function ( dataService ) {
    return{
        restrict : 'A',
        link : function(scope, element, attrs){
            scope.deletePicture = function(){
                event_id   = element.attr("data-event-id");
                edition_id = element.attr("data-edition-id");
                pictureID  = element.attr("data-picture-id");
                console.log( event_id + "," + edition_id + "," + pictureID );

                dataService.deletePicture( event_id, edition_id, pictureID )
                .then( deletePictureSuccess, deletePictureError );

                function deletePictureSuccess( msg ){
                    console.log('success: ' + msg );
                }
                function deletePictureError( errorMsg ){
                    console.log('Error Message: ' + errorMsg );
                }


            }
        }
    }
});


 //
 /*
app.directive("simplegallery", function () {
    var res = {
      restrict : 'C',
      link     : function (scope, element, attrs) {
            scope.$watch(attrs.simplegallery, function(){             
                element.simplegallery({
                    galltime : 400,
                    gallcontent: '.content',
                    gallthumbnail: '.thumbnail',
                    gallthumb: '.thumb'
                });
                console.log("hi");
            });
        },
        controller: function(dataService, $scope, $element, $attrs){
            $attrs.$observe('simplegallery', function (newsimplegallery) {
                if (newsimplegallery) {
                    $element.simplegallery({
                        galltime : 400,
                        gallcontent: '.content',
                        gallthumbnail: '.thumbnail',
                        gallthumb: '.thumb'
                    });
                    console.log("hi");
                }
            });  
        }
    };
   return res;
 }); 
 */





