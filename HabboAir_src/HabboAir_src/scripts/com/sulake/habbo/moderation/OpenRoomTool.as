package com.sulake.habbo.moderation
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils1;
   
   public class OpenRoomTool
   {
      private var _frame:IFrameController;
      
      private var _main:ModerationManager;
      
      private var UnknownVarFromOpenRoomTool_Int_1:int;
      
      public function OpenRoomTool(param1:IFrameController, param2:ModerationManager, param3:IWindowModel, param4:int)
      {
         super();
         _frame = param1;
         _main = param2;
         UnknownVarFromOpenRoomTool_Int_1 = param4;
         param3.procedure = onClick;
      }
      
      private function onClick(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         _main.windowTracker.show(new RoomToolCtrl(_main,UnknownVarFromOpenRoomTool_Int_1),_frame,false,false,true);
      }
      
      private function onAlertClose(param1:UnknownICoreWindowUtils1, param2:WindowEvent) : void
      {
         param1.dispose();
      }
   }
}

