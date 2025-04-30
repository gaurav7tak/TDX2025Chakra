public class KnowledgeArticleController{
    @InvocableMethod
    public static List<Response> getKnowledgeArticles() {
        List<Response> responses = new List<Response>();
        Response output = new Response();
        responses.add(output);
        List<Knowledge__kav> articleList = new List<Knowledge__kav>();
        articleList = [SELECT Id, Answer__c,Question__c,Summary__c FROM Knowledge__kav];
        output.Prompt = 'Following are the FAQ articles';
        for(Knowledge__kav knowledgeRecord: articleList){
            output.Prompt += '\nQuestion: '+knowledgeRecord.Question__c;
            output.Prompt += '\nAnswer: '+knowledgeRecord.Answer__c;
            output.Prompt += '\nSummary: '+knowledgeRecord.Summary__c;
            output.Prompt += '**********************************';
        }
        

        return responses;
    }

    public class Response {
        @InvocableVariable
        public String Prompt;
    }
}