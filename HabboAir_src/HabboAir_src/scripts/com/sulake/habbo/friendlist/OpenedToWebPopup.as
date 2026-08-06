package com.sulake.habbo.friendlist
{
   import com.sulake.core.window.IWindowController_1;
   import flash.events.Event;
   import flash.utils.Timer;
   
   public class OpenedToWebPopup
   {
      private var _friendList:HabboFriendList;
      
      private var UnknownVarFromOpenedToWebPopup_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromOpenedToWebPopup_Timer_1:Timer;
      
      public function OpenedToWebPopup(param1:HabboFriendList)
      {
         super();
         _friendList = param1;
      }
      
      public function show(param1:int, param2:int) : void
      {
         if(UnknownVarFromOpenedToWebPopup_IWindowController_1_1 != null)
         {
            close(null);
         }
         UnknownVarFromOpenedToWebPopup_IWindowController_1_1 = getOpenedToWebAlert();
         if(UnknownVarFromOpenedToWebPopup_Timer_1 != null)
         {
            UnknownVarFromOpenedToWebPopup_Timer_1.stop();
         }
         UnknownVarFromOpenedToWebPopup_Timer_1 = new Timer(2000,1);
         UnknownVarFromOpenedToWebPopup_Timer_1.addEventListener("timer",close);
         UnknownVarFromOpenedToWebPopup_Timer_1.start();
         UnknownVarFromOpenedToWebPopup_IWindowController_1_1.x = param1;
         UnknownVarFromOpenedToWebPopup_IWindowController_1_1.y = param2;
      }
      
      private function close(param1:Event) : void
      {
         UnknownVarFromOpenedToWebPopup_IWindowController_1_1.destroy();
         UnknownVarFromOpenedToWebPopup_IWindowController_1_1 = null;
      }
      
      private function getOpenedToWebAlert() : IWindowController_1
      {
         var _loc1_:IWindowController_1 = IWindowController_1(_friendList.getXmlWindow("opened_to_web_popup"));
         _friendList.refreshButton(_loc1_,"opened_to_web",true,null,0);
         return _loc1_;
      }
   }
}

