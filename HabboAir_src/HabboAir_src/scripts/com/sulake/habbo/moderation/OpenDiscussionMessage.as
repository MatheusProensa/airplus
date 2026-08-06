package com.sulake.habbo.moderation
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.events.WindowEvent;
   
   public class OpenDiscussionMessage
   {
      private var _main:ModerationManager;
      
      private var _groupId:int;
      
      private var UnknownVarFromOpenDiscussionMessage_Int_1:int;
      
      private var UnknownVarFromOpenDiscussionMessage_Int_2:int;
      
      public function OpenDiscussionMessage(param1:ModerationManager, param2:IWindowModel, param3:int, param4:int, param5:int)
      {
         super();
         _main = param1;
         _groupId = param3;
         UnknownVarFromOpenDiscussionMessage_Int_1 = param4;
         UnknownVarFromOpenDiscussionMessage_Int_2 = param5;
         param2.procedure = onClick;
      }
      
      private function onClick(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         _main.openThreadMessage(_groupId,UnknownVarFromOpenDiscussionMessage_Int_1,UnknownVarFromOpenDiscussionMessage_Int_2);
      }
   }
}

