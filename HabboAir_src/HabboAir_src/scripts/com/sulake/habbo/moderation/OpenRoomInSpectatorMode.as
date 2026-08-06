package com.sulake.habbo.moderation
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.events.WindowEvent;
   
   public class OpenRoomInSpectatorMode
   {
      private var _main:ModerationManager;
      
      private var UnknownVarFromOpenRoomInSpectatorMode_Int_1:int;
      
      public function OpenRoomInSpectatorMode(param1:ModerationManager, param2:IWindowModel, param3:int)
      {
         super();
         _main = param1;
         UnknownVarFromOpenRoomInSpectatorMode_Int_1 = param3;
         param2.procedure = onClick;
      }
      
      private function onClick(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         _main.goToRoom(UnknownVarFromOpenRoomInSpectatorMode_Int_1);
      }
   }
}

