/**************************************************************************
    Author      :   Jagdeep Juneja
    Purpose     :   Trigger on Task object.
    Company     :   Appirio 
    History Of Changes Done 
    <Date>          <Name>              <Company>           <Purpose>
    2-Dec-17       Jagdeep Juneja        Appirio             Created
**************************************************************************/

trigger TaskTrigger on Task (before insert, before update) {

  system.debug('Begin Task Trigger');
    // The below is used to determine if we should bypass this trigger for
    if (Utility.canTrigger('TaskTrigger') && !System.isBatch()) {
      MAP<string, string> dispatcherMAP = new MAP<string, string>();
      
      if (trigger.isInsert) {
          system.debug('TRIGGER: IsUpdate - ' + trigger.isUpdate + ', IsInsert - ' + trigger.isInsert + ', IsDelete - ' 
            + trigger.isDelete + ', IsUndelete - ' + trigger.isUndelete + ', Size: ' + trigger.new.size());
          dispatcherMAP = TaskDispatcher.Trigger_Handler(
            null, null, 
            trigger.new, trigger.newMap, 
            trigger.isBefore, trigger.isAfter, trigger.isInsert, trigger.isUpdate, trigger.isDelete);
      } else if(Trigger.isUpdate){
          system.debug('TRIGGER: IsUpdate - ' + trigger.isUpdate + ', IsInsert - ' + trigger.isInsert + ', IsDelete - ' 
            + trigger.isDelete + ', IsUndelete - ' + trigger.isUndelete + ', Size: ' + trigger.new.size());
          dispatcherMAP = TaskDispatcher.Trigger_Handler(
            trigger.old, trigger.oldMap, 
            trigger.new, trigger.newMap, 
            trigger.isBefore, trigger.isAfter, trigger.isInsert, trigger.isUpdate, trigger.isDelete);
      } // end if (trigger.isDelete)
    system.debug('Errors returned: ' + dispatcherMAP);
  
      integer nIndex = 0;
      for (string strErrorID: dispatcherMAP.keySet()) {
          if (strErrorID.isNumeric()) {
              nIndex = integer.valueOf(strErrorID);
              Trigger.new[nIndex].addError(dispatcherMAP.get(strErrorID));
          } else {
              if (trigger.isDelete) {
                  Trigger.oldMap.get(strErrorID).addError(dispatcherMAP.get(strErrorID));
              } // END if(trigger.isDelete)
              else {
                Trigger.newMap.get(strErrorID).addError(dispatcherMAP.get(strErrorID));
              } // END else
          } // END if (strErrorID.isNumeric())
          nIndex ++;
      } // END for (string strErrorID : dispatcherMAP.keySet())    }
    } // END if (Utility.canTrigger('AccountTrigger'))  

}