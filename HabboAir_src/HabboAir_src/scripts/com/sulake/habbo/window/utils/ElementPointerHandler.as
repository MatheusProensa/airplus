package com.sulake.habbo.window.utils
{
   import com.sulake.habbo.communication.messages.incoming.notifications.ElementPointerMessageEvent;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   
   public class ElementPointerHandler
   {
      private var _windowManager:HabboWindowManagerComponent;
      
      private var UnknownVarFromElementPointerHandler_ElementPointerMessageEvent_1:ElementPointerMessageEvent;
      
      public function ElementPointerHandler(param1:HabboWindowManagerComponent)
      {
         super();
         _windowManager = param1;
         if(_windowManager.communication != null)
         {
            UnknownVarFromElementPointerHandler_ElementPointerMessageEvent_1 = new ElementPointerMessageEvent(onElementPointerMessage);
            _windowManager.communication.addHabboConnectionMessageEvent(UnknownVarFromElementPointerHandler_ElementPointerMessageEvent_1);
         }
      }
      
      private function onElementPointerMessage(param1:ElementPointerMessageEvent) : void
      {
         var _loc2_:String = param1.getParser().key;
         if(_loc2_ == null || _loc2_ == "")
         {
            _windowManager.hideHint();
         }
         else
         {
            _windowManager.showHint(_loc2_);
         }
      }
      
      public function dispose() : void
      {
         if(_windowManager.communication != null)
         {
            _windowManager.communication.removeHabboConnectionMessageEvent(UnknownVarFromElementPointerHandler_ElementPointerMessageEvent_1);
         }
         _windowManager = null;
      }
   }
}

