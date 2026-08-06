package com.sulake.habbo.moderation
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.events.WindowEvent;
   
   public class OpenDiscussionThread
   {
      private var _main:ModerationManager;
      
      private var _groupId:int;
      
      private var UnknownVarFromOpenDiscussionThread_Int_1:int;
      
      public function OpenDiscussionThread(param1:ModerationManager, param2:IWindowModel, param3:int, param4:int)
      {
         super();
         _main = param1;
         _groupId = param3;
         UnknownVarFromOpenDiscussionThread_Int_1 = param4;
         param2.procedure = onClick;
      }
      
      private function onClick(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         _main.openThread(_groupId,UnknownVarFromOpenDiscussionThread_Int_1);
      }
   }
}

