package com.sulake.habbo.navigator
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
   import com.sulake.habbo.communication.messages.outgoing.room.session.QuitMessageComposer;
   import flash.geom.Point;
   
   public class GuestRoomDoorbell
   {
      private var _navigator:IHabboNavigator_2;
      
      private var _window:IFrameController;
      
      private var UnknownVarFromGuestRoomDoorbell_GuestRoomData_1:GuestRoomData;
      
      private var UnknownVarFromGuestRoomDoorbell_Boolean_1:Boolean;
      
      public function GuestRoomDoorbell(param1:IHabboNavigator_2)
      {
         super();
         _navigator = param1;
      }
      
      public function show(param1:GuestRoomData, param2:Point = null, param3:Boolean = false) : void
      {
         if(param1 == null)
         {
            return;
         }
         UnknownVarFromGuestRoomDoorbell_GuestRoomData_1 = param1;
         UnknownVarFromGuestRoomDoorbell_Boolean_1 = param3;
         createWindow();
         if(_window == null)
         {
            return;
         }
         if(param2 != null)
         {
            param2.offset(-_window.width / 2,-_window.height / 2);
            _window.setGlobalPosition(param2);
         }
         _window.visible = true;
         _window.activate();
         var _loc4_:ITextWindow = _window.findChildByName("room_name") as ITextWindow;
         if(_loc4_ != null)
         {
            _loc4_.text = param1.roomName;
         }
         if(UnknownVarFromGuestRoomDoorbell_Boolean_1)
         {
            setText("info","${navigator.doorbell.waiting}");
            setText("cancel","${navigator.doorbell.button.cancel.entering}");
            showButton("ring",false);
         }
         else
         {
            setText("info","${navigator.doorbell.info}");
            setText("cancel","${generic.cancel}");
            showButton("ring",true);
         }
      }
      
      public function showWaiting() : void
      {
         show(UnknownVarFromGuestRoomDoorbell_GuestRoomData_1,null,true);
      }
      
      public function showNoAnswer() : void
      {
         if(_window == null)
         {
            return;
         }
         _window.visible = true;
         _window.activate();
         setText("info","${navigator.doorbell.no.answer}");
         showButton("ring",false);
      }
      
      private function showButton(param1:String, param2:Boolean) : void
      {
         var _loc3_:UnknownICoreWindowComponents4 = _window.findChildByName(param1) as UnknownICoreWindowComponents4;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.visible = param2;
      }
      
      private function createWindow() : void
      {
         if(_window != null)
         {
            return;
         }
         var _loc2_:XmlAsset = _navigator.assets.getAssetByName("doorbell_xml") as XmlAsset;
         _window = _navigator.windowManager.buildFromXML(_loc2_.content as XML,2) as IFrameController;
         if(_window == null)
         {
            return;
         }
         var _loc4_:UnknownICoreWindowComponents4 = _window.findChildByName("ring") as UnknownICoreWindowComponents4;
         if(_loc4_ != null)
         {
            _loc4_.addEventListener("WME_CLICK",ringDoorbell);
         }
         var _loc3_:IWindowModel = _window.findChildByName("cancel_region");
         if(_loc3_ != null)
         {
            _loc3_.addEventListener("WME_CLICK",close);
         }
         var _loc1_:IWindowModel = _window.findChildByTag("close");
         if(_loc1_ != null)
         {
            _loc1_.addEventListener("WME_CLICK",close);
         }
      }
      
      private function setText(param1:String, param2:String) : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc3_:IWindowModel = _window.findChildByName(param1);
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.caption = param2;
      }
      
      public function dispose() : void
      {
         if(_window != null)
         {
            _window.dispose();
         }
         _window = null;
         _navigator = null;
         UnknownVarFromGuestRoomDoorbell_GuestRoomData_1 = null;
      }
      
      private function ringDoorbell(param1:WindowMouseEvent) : void
      {
         _navigator.goToRoom(UnknownVarFromGuestRoomDoorbell_GuestRoomData_1.flatId,true);
         hide();
      }
      
      private function close(param1:WindowMouseEvent) : void
      {
         if(_window == null)
         {
            return;
         }
         if(UnknownVarFromGuestRoomDoorbell_Boolean_1 && _navigator != null)
         {
            _navigator.send(new QuitMessageComposer());
         }
         _window.dispose();
         _window = null;
      }
      
      public function hide() : void
      {
         if(_window == null)
         {
            return;
         }
         _window.visible = false;
      }
   }
}

