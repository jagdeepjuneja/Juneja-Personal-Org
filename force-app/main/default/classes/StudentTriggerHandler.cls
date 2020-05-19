public class StudentTriggerHandler {
  
   public void afterInsert(List<Student__c> studentList){
     updateCountOnTeacher(studentList);
   }
   
   public void updateCountOnTeacher(List<Student__c> studentList){
     
     Set<Id> teacherIdSet = new Set<Id>();
     Map<String, List<Student__c>> mapOfTeacherIdAndStuList = new Map<String, List<Student__c>>();
     List<Teacher__c> teacherListToUpdate = new List<Teacher__c>();
     
     for(Student__c stu : studentList){
       if(stu.Teacher_Name__c != NULL ){
         teacherIdSet.add(stu.Teacher_Name__c);
       }
     }
     
     if(!teacherIdSet.isEmpty()){
       for(Student__c stu : [SELECT Class_Name__c, Teacher_Name__c FROM Student__c WHERE Teacher_Name__c IN :teacherIdSet
                              AND (Class_Name__c = '10' OR Class_Name__c = '12')]){
                                
         if(mapOfTeacherIdAndStuList.containsKey(stu.Teacher_Name__c)){
           mapOfTeacherIdAndStuList.get(stu.Teacher_Name__c).add(stu);
         }
         else{
           mapOfTeacherIdAndStuList.put(stu.Teacher_Name__c, new List<Student__c>{stu});
         }
       }
       
       if(!mapOfTeacherIdAndStuList.isEmpty()){
         for(String teacherId : mapOfTeacherIdAndStuList.keySet()){
           teacherListToUpdate.add(new Teacher__c(Id = teacherId, Student_Count__c = mapOfTeacherIdAndStuList.get(teacherId).size()));
         }
       }
       
       if(!teacherListToUpdate.isEmpty()){
         update teacherListToUpdate;
       }
     }
   }
}