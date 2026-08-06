package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils2;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.CheckboxOptionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.CheckboxGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class SendSignal extends DefaultActionType
   {
      private var _signalOptions:CheckboxGroupPreset;
      
      private var _ignoreCheckboxEvents:Boolean;
      
      public function SendSignal()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.SEND_SIGNAL;
      }
      
      override public function get negativeCode() : int
      {
         return ActionTypeCodes.NEG_SEND_SIGNAL;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         var _loc5_:Array = [new CheckboxOptionParam(l("signal.split_furni")),new CheckboxOptionParam(l("signal.split_users"))];
         _signalOptions = param1.createCheckboxGroup(_loc5_,onChangeCheckbox);
         var _loc4_:SectionPreset = param1.createSection(l("signal.send_options"),_signalOptions);
         param3.addElements(_loc4_);
      }
      
      private function onChangeCheckbox(param1:int, param2:Boolean) : void
      {
         var id:int = param1;
         var value:Boolean = param2;
         if(_ignoreCheckboxEvents)
         {
            return;
         }
         if(value)
         {
            roomEvents.windowManager.confirm("${wiredfurni.params.signal_warning.title}","${wiredfurni.params.signal_warning.desc}",0,function(param1:UnknownICoreWindowUtils2, param2:WindowEvent):void
            {
               param1.dispose();
               if(param2.type != "WE_OK")
               {
                  _signalOptions.get(id).selected = false;
               }
            });
         }
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         _ignoreCheckboxEvents = true;
         _signalOptions.get(0).selected = param1.getBoolean(0);
         _signalOptions.get(1).selected = param1.getBoolean(1);
         _ignoreCheckboxEvents = false;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [_signalOptions.get(0).selected,_signalOptions.get(1).selected];
      }
      
      override public function furniSelectionTitle(param1:int) : String
      {
         if(param1 == 0)
         {
            return "wiredfurni.params.sources.furni.title.signal_antenna";
         }
         return "wiredfurni.params.sources.furni.title.signal_forward";
      }
      
      override public function userSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.users.title.signal_forward";
      }
   }
}

