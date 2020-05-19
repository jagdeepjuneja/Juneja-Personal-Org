({
   afterRender : function( component, helper ) {
	   this.superAfterRender();

       var div = component.find("mainDiv").getElement();

       div.onscroll = $A.getCallback(function(){
           if ((div.scrollHeight - div.scrollTop) == div.style.maxHeight.substring(0, div.style.maxHeight.indexOf('p'))) 
           {
               helper.getNextPage( component );
           }
       });
   }
})