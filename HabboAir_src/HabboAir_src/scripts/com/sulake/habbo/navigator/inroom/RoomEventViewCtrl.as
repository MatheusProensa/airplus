package com.sulake.habbo.navigator.inroom
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.advertisement.RoomAdErrorEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.RoomEventData;
   import com.sulake.habbo.communication.messages.outgoing.navigator.CancelEventMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.EditEventMessageComposer;
   import com.sulake.habbo.communication.messages.parser.advertisement.RoomAdErrorMessageParser;
   import com.sulake.habbo.navigator.IHabboNavigator_2;
   import com.sulake.habbo.navigator.TextFieldManager;
   
   public class RoomEventViewCtrl implements IComponentInterfaceQueue
   {
      private var _navigator:IHabboNavigator_2;
      
      private var _window:IFrameController;
      
      private var UnknownVarFromRoomEventViewCtrl_TextFieldManager_1:TextFieldManager;
      
      private var UnknownVarFromRoomEventViewCtrl_TextFieldManager_2:TextFieldManager;
      
      public function RoomEventViewCtrl(param1:IHabboNavigator_2)
      {
         super();
         _navigator = param1;
      }
      
      public function dispose() : void
      {
         _navigator = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         UnknownVarFromRoomEventViewCtrl_TextFieldManager_1 = null;
         UnknownVarFromRoomEventViewCtrl_TextFieldManager_2 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _navigator == null;
      }
      
      public function show() : void
      {
         if(_window != null && Boolean(_window.visible))
         {
            _window.visible = false;
            return;
         }
         prepareWindow();
         clearErrors();
         var _loc1_:RoomEventData = _navigator.data.roomEventData;
         if(_loc1_ == null)
         {
            createEvent();
         }
         else
         {
            editEvent(_loc1_);
         }
         _window.visible = true;
         _window.activate();
      }
      
      private function editEvent(param1:RoomEventData) : void
      {
         _window.caption = _navigator.getText("navigator.eventsettings.editcaption");
         UnknownVarFromRoomEventViewCtrl_TextFieldManager_1.setText(param1.eventName);
         UnknownVarFromRoomEventViewCtrl_TextFieldManager_2.setText(param1.eventDescription);
      }
      
      private function createEvent() : void
      {
         _window.caption = _navigator.getText("navigator.createevent");
         UnknownVarFromRoomEventViewCtrl_TextFieldManager_2.goBackToInitialState();
         UnknownVarFromRoomEventViewCtrl_TextFieldManager_1.goBackToInitialState();
      }
      
      private function getInput(param1:String) : ITextFieldWindow
      {
         return ITextFieldWindow(_window.findChildByName(param1));
      }
      
      private function onClose(param1:WindowEvent) : void
      {
         close();
      }
      
      private function save() : void
      {
         var _loc1_:int = _navigator.data.roomEventData.adId;
         var _loc3_:String = UnknownVarFromRoomEventViewCtrl_TextFieldManager_1.getText();
         var _loc2_:String = UnknownVarFromRoomEventViewCtrl_TextFieldManager_2.getText();
         if(!isMandatoryFieldsFilled())
         {
            return;
         }
         _navigator.send(new EditEventMessageComposer(_loc1_,_loc3_,_loc2_));
      }
      
      private function onEndButtonClick(param1:WindowEvent) : void
      {
         _navigator.send(new CancelEventMessageComposer(_navigator.data.roomEventData.adId));
         close();
      }
      
      private function onCancelButtonClick(param1:WindowEvent) : void
      {
         close();
      }
      
      private function onUnfocus(param1:WindowEvent) : void
      {
         if(_navigator.data.roomEventData != null)
         {
            save();
         }
      }
      
      private function onRoomAdError(param1:RoomAdErrorEvent) : void
      {
         this.clearErrors();
         var _loc2_:RoomAdErrorMessageParser = param1.getParser();
         var _loc3_:int = _loc2_.errorCode;
         if(_loc3_ == 0)
         {
            UnknownVarFromRoomEventViewCtrl_TextFieldManager_1.displayError(_navigator.getText("roomad.error.0.description"));
            UnknownVarFromRoomEventViewCtrl_TextFieldManager_1.setText(_loc2_.filteredText);
         }
         else if(_loc3_ == 1)
         {
            UnknownVarFromRoomEventViewCtrl_TextFieldManager_2.displayError(_navigator.getText("roomad.error.0.description"));
            UnknownVarFromRoomEventViewCtrl_TextFieldManager_2.setText(_loc2_.filteredText);
         }
      }
      
      private function isMandatoryFieldsFilled() : Boolean
      {
         this.clearErrors();
         if(!UnknownVarFromRoomEventViewCtrl_TextFieldManager_1.checkMandatory(_navigator.getText("navigator.eventsettings.nameerr")))
         {
            return false;
         }
         return true;
      }
      
      private function clearErrors() : void
      {
         UnknownVarFromRoomEventViewCtrl_TextFieldManager_1.clearErrors();
         UnknownVarFromRoomEventViewCtrl_TextFieldManager_2.clearErrors();
      }
      
      private function prepareWindow() : void
      {
         if(_window != null)
         {
            return;
         }
         _window = IFrameController(_navigator.getXmlWindow("iro_event_settings"));
         addMouseClickListener(_window.findChildByTag("close"),onClose);
         UnknownVarFromRoomEventViewCtrl_TextFieldManager_1 = new TextFieldManager(_navigator,getInput("event_name"),25);
         UnknownVarFromRoomEventViewCtrl_TextFieldManager_2 = new TextFieldManager(_navigator,getInput("event_desc"),100);
         UnknownVarFromRoomEventViewCtrl_TextFieldManager_1.input.addEventListener("WE_UNFOCUSED",onUnfocus);
         UnknownVarFromRoomEventViewCtrl_TextFieldManager_2.input.addEventListener("WE_UNFOCUSED",onUnfocus);
         _navigator.communication.addHabboConnectionMessageEvent(new RoomAdErrorEvent(onRoomAdError));
         _window.center();
      }
      
      private function addMouseClickListener(param1:IWindowModel, param2:Function) : void
      {
         if(param1 != null)
         {
            param1.addEventListener("WME_CLICK",param2);
         }
      }
      
      private function find(param1:String) : IWindowModel
      {
         var _loc2_:IWindowModel = _window.findChildByName(param1);
         if(_loc2_ == null)
         {
            throw new Error("Window element with name: " + param1 + " cannot be found!");
         }
         return _loc2_;
      }
      
      private function prepareEventTypes() : void
      {
         var _loc2_:int = 0;
         var _loc4_:String = null;
         var _loc1_:String = null;
         var _loc3_:Array = [];
         var _loc5_:int = 100;
         _loc2_ = 1;
         while(_loc2_ < _loc5_)
         {
            _loc4_ = "roomevent_type_" + _loc2_;
            _loc1_ = _navigator.getText(_loc4_);
            if(_loc1_ == null || _loc1_ == _loc4_)
            {
               break;
            }
            _loc3_.push(_loc1_);
            _loc2_++;
         }
      }
      
      public function close() : void
      {
         if(_window != null)
         {
            _window.visible = false;
         }
      }
   }
}

