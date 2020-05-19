<aura:application >
    <c:IdCardComp >
      <aura:set attribute="IdCardHeading">
        Id Card Detail  
      </aura:set>
      <aura:set attribute="image">
       <img src="/resource/MyImage" height="300" width="300" style='margin-left:480px'/>
      </aura:set> 
      <aura:set attribute="name">
        Jagdeep Juneja 
      </aura:set>
      <aura:set attribute="idCardNumber">
        01912  
      </aura:set>  
    </c:IdCardComp>
    <c:helloMessage message="You are great"></c:helloMessage>
</aura:application>