var app = angular.module("myApp", []);

app.factory( 'dataService',function($http,$q) {
    return{
        getAllContacts: getAllContacts
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

} )

app.controller("mainCtrl", function( dataService, $scope ){

    var vm = this;
    theID = null;
    vm.length = 0;
    vm.perPageArr = [3, 5, 10, 20, 50];
    vm.curentPage = 1;
    vm.perPage = vm.perPage | 5 ;
    vm.numberPaginationArr = [];

    
    

    function getContactsSuccess( contacts ){
        vm.allContacts = contacts;
        vm.length = contacts.length;
        calculatePagination();
    }
    
    function getContactsError( errorMsg ){
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

    }

    //navigation events
    navigation = function( mode ){
        //console.log(vm.curentPage);
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

    //private
    calculatePagination = function(){
        vm.numberPagination =  Math.ceil( vm.length / vm.perPage );
        vm.numberPaginationArr = [];
        for(i=0; vm.numberPagination > i ; i++){
            vm.numberPaginationArr.push( i );
        }
        console.log("vm.numberPagination : " + vm.numberPagination);
        console.log("vm.curentPage : " + vm.curentPage);
        console.log("vm.perPage : " + vm.perPage);
        
        
        //console.log( vm.numberPaginationArr );
    }

    //Watchers

    $scope.$watch("vm.id", function( newID ){
        theID = newID;
        //get all Contacts
        dataService.getAllContacts( theID )
            .then( getContactsSuccess, getContactsError );
        calculatePagination();
    });

    $scope.$watch("vm.perPage", function( ){
        vm.curentPage = 1;
        calculatePagination();
    });

    $scope.$watch("vm.curentPage", function( ){
        calculatePagination();
    });

})