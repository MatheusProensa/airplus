package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.components.UnknownICoreWindowComponents5;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class ContainerButtonPreset extends PaddedContainerPreset
   {
      private var UnknownVarFromContainerButtonPreset_Function_1:Function;
      
      public function ContainerButtonPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:WiredUIPreset, param5:Function, param6:Boolean = true)
      {
         super(param1,param2,param3,param4,param3.containerButtonPaddingLeft,param3.containerButtonPaddingTop,param3.containerButtonPaddingLeft,param3.containerButtonPaddingTop,param3.createContainerButton(),param6);
         UnknownVarFromContainerButtonPreset_Function_1 = param5;
         button.addEventListener("WME_CLICK",buttonClicked);
      }
      
      private function buttonClicked(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromContainerButtonPreset_Function_1 != null)
         {
            UnknownVarFromContainerButtonPreset_Function_1();
         }
      }
      
      private function get button() : UnknownICoreWindowComponents5
      {
         return _window as UnknownICoreWindowComponents5;
      }
   }
}

