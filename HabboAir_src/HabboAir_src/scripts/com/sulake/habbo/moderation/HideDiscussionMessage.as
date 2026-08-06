package com.sulake.habbo.moderation
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.outgoing.groupforums.ModerateMessageMessageComposer;
   
   public class HideDiscussionMessage
   {
      private var _main:ModerationManager;
      
      private var _popup:ChatlogCtrl;
      
      private var _groupId:int;
      
      private var UnknownVarFromHideDiscussionMessage_Int_1:int;
      
      private var UnknownVarFromHideDiscussionMessage_Int_2:int;
      
      public function HideDiscussionMessage(param1:ModerationManager, param2:ChatlogCtrl, param3:IWindowModel, param4:int, param5:int, param6:int)
      {
         super();
         _main = param1;
         _popup = param2;
         _groupId = param4;
         UnknownVarFromHideDiscussionMessage_Int_1 = param5;
         UnknownVarFromHideDiscussionMessage_Int_2 = param6;
         param3.procedure = onClick;
      }
      
      private function onClick(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         _popup.dispose();
         _main.connection.send(new ModerateMessageMessageComposer(_groupId,UnknownVarFromHideDiscussionMessage_Int_1,UnknownVarFromHideDiscussionMessage_Int_2,20));
      }
   }
}

