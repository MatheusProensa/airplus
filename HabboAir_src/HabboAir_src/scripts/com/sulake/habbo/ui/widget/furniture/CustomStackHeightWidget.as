package com.sulake.habbo.ui.widget.furniture
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents2;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.SetAdjacentCustomStackingHeightComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.SetCustomStackingHeightComposer;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.handler.FurnitureCustomStackHeightWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class CustomStackHeightWidget extends RoomWidgetBase
   {
      private static const SLIDER_RANGE:int = 10;
      
      private static const MAX_HEIGHT:int = 80;
      
      private static const SLIDER_BUTTON_WIDTH:int = 20;
      
      private static const SLIDER_LIVE_UPDATE_INTERVAL_MS:int = 30;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromCustomStackHeightWidget_Int_1:int;
      
      private var _ignoreCheckboxEvents:Boolean;
      
      private var _ignoreInputChangeEvents:Boolean;
      
      private var UnknownVarFromCustomStackHeightWidget_Boolean_1:Boolean;
      
      private var _hasUnsavedInputChanges:Boolean;
      
      private var UnknownVarFromCustomStackHeightWidget_Boolean_2:Boolean;
      
      private var UnknownVarFromCustomStackHeightWidget_Boolean_3:Boolean;
      
      private var UnknownVarFromCustomStackHeightWidget_Boolean_4:Boolean;
      
      private var _lastSliderSendTime:int = -30;
      
      private var UnknownVarFromCustomStackHeightWidget_Number_1:Number = NaN;
      
      private var UnknownVarFromCustomStackHeightWidget_Timer_1:Timer;
      
      public function CustomStackHeightWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection = null, param4:IHabboLocalizationManager = null)
      {
         super(param1,param2,param3,param4);
         FurnitureCustomStackHeightWidgetHandler(param1).widget = this;
         UnknownVarFromCustomStackHeightWidget_Timer_1 = new Timer(30,1);
         UnknownVarFromCustomStackHeightWidget_Timer_1.addEventListener("timerComplete",onSliderSendTimer);
      }
      
      override public function dispose() : void
      {
         destroyWindow();
         if(UnknownVarFromCustomStackHeightWidget_Timer_1)
         {
            UnknownVarFromCustomStackHeightWidget_Timer_1.stop();
            UnknownVarFromCustomStackHeightWidget_Timer_1.removeEventListener("timerComplete",onSliderSendTimer);
            UnknownVarFromCustomStackHeightWidget_Timer_1 = null;
         }
         super.dispose();
      }
      
      override public function get mainWindow() : IWindowModel
      {
         return _window;
      }
      
      private function createWindow() : void
      {
         if(!_window)
         {
            _window = IWindowController_1(windowManager.buildFromXML(XML(assets.getAssetByName("custom_stack_height_xml").content)));
            _window.procedure = windowProcedure;
            _window.center();
            multiWalkCheckbox.addEventListener("WE_SELECTED",onMultiWalkChange);
            multiWalkCheckbox.addEventListener("WE_UNSELECTED",onMultiWalkChange);
            inputHeightField.addEventListener("WE_CHANGE",onInputHeightChange);
            inputHeightField.addEventListener("WE_UNFOCUS",onInputHeightUnfocus);
            inputHeightField.addEventListener("WE_UNFOCUSED",onInputHeightUnfocus);
         }
      }
      
      private function onMultiWalkChange(param1:WindowEvent) : void
      {
         if(_ignoreCheckboxEvents)
         {
            return;
         }
         handler.container.connection.send(new SetCustomStackingHeightComposer([UnknownVarFromCustomStackHeightWidget_Int_1,currentHeight,multiWalkMode]));
      }
      
      public function open(param1:int, param2:Number, param3:Boolean, param4:Boolean) : void
      {
         UnknownVarFromCustomStackHeightWidget_Int_1 = param1;
         param2 = Math.min(param2,80);
         resetInteractionState();
         if(_window == null)
         {
            createWindow();
         }
         walkTileContainer.visible = param3;
         if(param3)
         {
            _ignoreCheckboxEvents = true;
            if(param4)
            {
               multiWalkCheckbox.select();
            }
            else
            {
               multiWalkCheckbox.unselect();
            }
            _ignoreCheckboxEvents = false;
         }
         _window.height = param3 ? _window.limits.maxHeight : int(_window.limits.minHeight);
         var _loc5_:String = param3 ? "walk" : "stack";
         UnknownVarFromCustomStackHeightWidget_Number_1 = param2;
         _window.caption = localizations.getLocalization("widget.custom." + _loc5_ + ".height.title");
         _window.findChildByName("height_text").caption = localizations.getLocalization("widget.custom." + _loc5_ + ".height.text");
         setInputHeightCaption(param2.toString());
         updateSlider();
         _window.visible = true;
      }
      
      public function hide() : void
      {
         if(_window == null)
         {
            return;
         }
         resetInteractionState();
         _window.visible = false;
      }
      
      private function destroyWindow() : void
      {
         if(_window)
         {
            cancelPendingSliderSend();
            multiWalkCheckbox.removeEventListener("WE_SELECTED",onMultiWalkChange);
            multiWalkCheckbox.removeEventListener("WE_UNSELECTED",onMultiWalkChange);
            inputHeightField.removeEventListener("WE_CHANGE",onInputHeightChange);
            inputHeightField.removeEventListener("WE_UNFOCUS",onInputHeightUnfocus);
            inputHeightField.removeEventListener("WE_UNFOCUSED",onInputHeightUnfocus);
            _window.procedure = null;
            _window.dispose();
            _window = null;
         }
         resetInteractionState();
      }
      
      private function windowProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param2 == null)
         {
            return;
         }
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "button_floor_level":
                  cancelPendingSliderSend();
                  discardInputHeightEdit();
                  altitude = 0;
                  sendCurrentHeight();
                  break;
               case "button_above_stack":
                  cancelPendingSliderSend();
                  discardInputHeightEdit();
                  handler.container.connection.send(new SetCustomStackingHeightComposer([UnknownVarFromCustomStackHeightWidget_Int_1,-100]));
                  break;
               case "button_move_down":
                  cancelPendingSliderSend();
                  discardInputHeightEdit();
                  sendAdjacentHeightRequest(true);
                  break;
               case "button_move_up":
                  cancelPendingSliderSend();
                  discardInputHeightEdit();
                  sendAdjacentHeightRequest(false);
                  break;
               case "header_button_close":
                  destroyWindow();
                  break;
               case "slider":
                  discardInputHeightEdit();
                  sliderButton.x = clampSliderButtonX(WindowMouseEvent(param1).localX);
                  updateHeightSelection();
                  sendCurrentHeight();
                  _lastSliderSendTime = getTimer();
            }
         }
         else if(param1.type == "WME_DOWN")
         {
            var _loc3_:* = param2.name;
            if("slider_button" === _loc3_)
            {
               UnknownVarFromCustomStackHeightWidget_Boolean_1 = true;
               discardInputHeightEdit();
               UnknownVarFromCustomStackHeightWidget_Boolean_2 = false;
            }
         }
         else if(param1.type == "WME_UP" || param1.type == "WME_UP_OUTSIDE")
         {
            _loc3_ = param2.name;
            if("slider_button" === _loc3_)
            {
               UnknownVarFromCustomStackHeightWidget_Boolean_1 = false;
               if(UnknownVarFromCustomStackHeightWidget_Boolean_2)
               {
                  requestFinalSliderSend();
               }
            }
         }
         else if(param1.type == "WME_DOUBLE_CLICK")
         {
            _loc3_ = param2.name;
            if("slider_button" === _loc3_)
            {
               discardInputHeightEdit();
               updateHeightSelection(true);
               sendCurrentHeight();
               _lastSliderSendTime = getTimer();
            }
         }
         else if(param1.type == "WE_RELOCATED")
         {
            _loc3_ = param2.name;
            if("slider_button" === _loc3_)
            {
               updateHeightSelection();
               if(UnknownVarFromCustomStackHeightWidget_Boolean_1)
               {
                  UnknownVarFromCustomStackHeightWidget_Boolean_2 = true;
                  queueSliderLiveSend();
               }
            }
         }
         else if(param1.type == "WKE_KEY_DOWN")
         {
            if(param2.name == "input_height")
            {
               if(WindowKeyboardEvent(param1).keyCode == 13)
               {
                  cancelPendingSliderSend();
                  _hasUnsavedInputChanges = false;
                  updateSlider();
                  sendCurrentHeight();
               }
            }
         }
      }
      
      private function sendCurrentHeight() : void
      {
         handler.container.connection.send(new SetCustomStackingHeightComposer([UnknownVarFromCustomStackHeightWidget_Int_1,currentHeight]));
      }
      
      private function sendAdjacentHeightRequest(param1:Boolean) : void
      {
         handler.container.connection.send(new SetAdjacentCustomStackingHeightComposer(UnknownVarFromCustomStackHeightWidget_Int_1,param1));
      }
      
      private function get currentHeight() : int
      {
         return currentHeightValue * 100;
      }
      
      private function get multiWalkMode() : Boolean
      {
         return multiWalkCheckbox.isSelected;
      }
      
      private function updateSlider() : void
      {
         var _loc3_:Number = currentHeightValue;
         var _loc1_:Number = _loc3_ / 10;
         _loc1_ = Math.min(_loc1_,1);
         var _loc2_:Number = slider.width - 20;
         _window.procedure = null;
         sliderButton.x = _loc2_ * _loc1_;
         _window.procedure = windowProcedure;
      }
      
      private function updateHeightSelection(param1:Boolean = false) : void
      {
         var _loc4_:int = param1 ? 1 : 100;
         var _loc3_:Number = slider.width - 20;
         var _loc2_:Number = clampSliderButtonX(sliderButton.x) / _loc3_;
         var _loc5_:Number = _loc2_ * 10 * _loc4_;
         setInputHeightCaption((int(_loc5_) / (_loc4_ * 1)).toString());
      }
      
      private function get handler() : FurnitureCustomStackHeightWidgetHandler
      {
         return _widgetHandler as FurnitureCustomStackHeightWidgetHandler;
      }
      
      private function set altitude(param1:Number) : void
      {
         if(_window != null)
         {
            setInputHeightCaption(param1.toString());
            updateSlider();
         }
      }
      
      public function updateHeight(param1:int, param2:Number) : void
      {
         if(UnknownVarFromCustomStackHeightWidget_Int_1 == param1)
         {
            UnknownVarFromCustomStackHeightWidget_Number_1 = param2;
            if(canApplyLiveHeight())
            {
               altitude = param2;
            }
         }
      }
      
      private function get walkTileContainer() : IWindowController_1
      {
         return _window.findChildByName("walktile_container") as IWindowController_1;
      }
      
      private function get multiWalkCheckbox() : UnknownICoreWindowComponents2
      {
         return _window.findChildByName("multiwalk_checkbox") as UnknownICoreWindowComponents2;
      }
      
      private function get inputHeightField() : ITextFieldWindow
      {
         return _window.findChildByName("input_height") as ITextFieldWindow;
      }
      
      private function get slider() : IWindowModel
      {
         return _window.findChildByName("slider");
      }
      
      private function get sliderButton() : IWindowModel
      {
         return _window.findChildByName("slider_button");
      }
      
      private function get currentHeightValue() : Number
      {
         var _loc1_:Number = parseFloat(inputHeightField.caption);
         return isNaN(_loc1_) ? 0 : _loc1_;
      }
      
      private function onInputHeightChange(param1:WindowEvent) : void
      {
         if(_ignoreInputChangeEvents)
         {
            return;
         }
         _hasUnsavedInputChanges = true;
      }
      
      private function onInputHeightUnfocus(param1:WindowEvent) : void
      {
         if(_hasUnsavedInputChanges && !isNaN(UnknownVarFromCustomStackHeightWidget_Number_1))
         {
            altitude = UnknownVarFromCustomStackHeightWidget_Number_1;
         }
         _hasUnsavedInputChanges = false;
      }
      
      private function queueSliderLiveSend() : void
      {
         UnknownVarFromCustomStackHeightWidget_Boolean_3 = true;
         scheduleSliderSend();
      }
      
      private function requestFinalSliderSend() : void
      {
         UnknownVarFromCustomStackHeightWidget_Boolean_4 = true;
         scheduleSliderSend();
      }
      
      private function scheduleSliderSend() : void
      {
         if(!UnknownVarFromCustomStackHeightWidget_Timer_1)
         {
            return;
         }
         var _loc1_:int = getTimer() - _lastSliderSendTime;
         if(_loc1_ >= 30)
         {
            sendPendingSliderHeight();
            return;
         }
         UnknownVarFromCustomStackHeightWidget_Timer_1.reset();
         UnknownVarFromCustomStackHeightWidget_Timer_1.delay = Math.max(1,30 - _loc1_);
         UnknownVarFromCustomStackHeightWidget_Timer_1.start();
      }
      
      private function onSliderSendTimer(param1:TimerEvent) : void
      {
         sendPendingSliderHeight();
      }
      
      private function sendPendingSliderHeight() : void
      {
         if(!UnknownVarFromCustomStackHeightWidget_Boolean_3 && !UnknownVarFromCustomStackHeightWidget_Boolean_4)
         {
            return;
         }
         sendCurrentHeight();
         _lastSliderSendTime = getTimer();
         UnknownVarFromCustomStackHeightWidget_Boolean_3 = false;
         if(!UnknownVarFromCustomStackHeightWidget_Boolean_1)
         {
            UnknownVarFromCustomStackHeightWidget_Boolean_4 = false;
         }
      }
      
      private function cancelPendingSliderSend() : void
      {
         if(UnknownVarFromCustomStackHeightWidget_Timer_1)
         {
            UnknownVarFromCustomStackHeightWidget_Timer_1.reset();
         }
         UnknownVarFromCustomStackHeightWidget_Boolean_3 = false;
         UnknownVarFromCustomStackHeightWidget_Boolean_4 = false;
         UnknownVarFromCustomStackHeightWidget_Boolean_1 = false;
         UnknownVarFromCustomStackHeightWidget_Boolean_2 = false;
      }
      
      private function resetInteractionState() : void
      {
         cancelPendingSliderSend();
         _hasUnsavedInputChanges = false;
         _lastSliderSendTime = -30;
      }
      
      private function canApplyLiveHeight() : Boolean
      {
         if(_window.findChildByName("keep_height_checkbox").isSelected)
         {
            return false;
         }
         return !UnknownVarFromCustomStackHeightWidget_Boolean_1 && !_hasUnsavedInputChanges && !UnknownVarFromCustomStackHeightWidget_Boolean_4 && !UnknownVarFromCustomStackHeightWidget_Boolean_3;
      }
      
      private function discardInputHeightEdit() : void
      {
         _hasUnsavedInputChanges = false;
      }
      
      private function setInputHeightCaption(param1:String) : void
      {
         _ignoreInputChangeEvents = true;
         inputHeightField.caption = param1;
         _ignoreInputChangeEvents = false;
      }
      
      private function clampSliderButtonX(param1:Number) : Number
      {
         return Math.max(0,Math.min(param1,slider.width - 20));
      }
   }
}

