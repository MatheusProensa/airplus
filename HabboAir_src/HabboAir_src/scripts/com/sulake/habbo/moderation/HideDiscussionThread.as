package com.sulake.habbo.moderation
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.outgoing.groupforums.ModerateThreadMessageComposer;
   
   public class HideDiscussionThread
   {
      private var _main:ModerationManager;
      
      private var _popup:ChatlogCtrl;
      
      private var _groupId:int;
      
      private var UnknownVarFromHideDiscussionThread_Int_1:int;
      
      public function HideDiscussionThread(param1:ModerationManager, param2:ChatlogCtrl, param3:IWindowModel, param4:int, param5:int)
      {
         super();
         _main = param1;
         _popup = param2;
         _groupId = param4;
         UnknownVarFromHideDiscussionThread_Int_1 = param5;
         param3.procedure = onClick;
      }
      
      private function onClick(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         _popup.dispose();
         _main.connection.send(new ModerateThreadMessageComposer(_groupId,UnknownVarFromHideDiscussionThread_Int_1,20));
      }
   }
}

