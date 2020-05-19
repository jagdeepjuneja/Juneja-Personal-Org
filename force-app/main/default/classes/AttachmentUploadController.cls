public class AttachmentUploadController {
    @AuraEnabled
    public static Id insertFile(String fileName, String base64Data, String contentType) {
        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
        Attachment attach = new Attachment();
        attach.parentId = 'a0j6F00000WdQBx';
        attach.Body = EncodingUtil.base64Decode(base64Data);
        attach.Name = fileName;
        attach.ContentType = contentType;
        Insert attach;
        return attach.Id;
    }
    
    
    @AuraEnabled
    public static List<Attachment> retrieveFiles() {
        List<Attachment> attList = [SELECT Name FROM Attachment where parentId = 'a0j6F00000WdQBx'];
        return attList;
    }
}