package com.sulake.habbo.util
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.outgoing.friendlist.FollowFriendMessageComposer;
   import com.sulake.habbo.moderation.ModerationManager;
   
   public class VisitUserUtil
   {
      private var _main:ModerationManager;
      
      private var UnknownVarFromVisitUserUtil_Int_1:int;
      
      public function VisitUserUtil(param1:ModerationManager, param2:IWindowModel, param3:int)
      {
         super();
         _main = param1;
         UnknownVarFromVisitUserUtil_Int_1 = param3;
         param2.procedure = onClick;
      }
      
      private function onClick(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         _main.connection.send(new FollowFriendMessageComposer(UnknownVarFromVisitUserUtil_Int_1));
      }
   }
}

