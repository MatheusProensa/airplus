package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class TextualButtonPreset extends WiredUIPreset
   {
      private var _container:IWindowController_1;
      
      private var UnknownVarFromTextualButtonPreset_TextPreset_1:TextPreset;
      
      private var UnknownVarFromTextualButtonPreset_Function_1:Function;
      
      public function TextualButtonPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:String, param5:Function)
      {
         super(param1,param2,param3);
         UnknownVarFromTextualButtonPreset_Function_1 = param5;
         _container = param2.createLayout("growing_container_view") as IWindowController_1;
         UnknownVarFromTextualButtonPreset_TextPreset_1 = param2.createText(param4,new TextParam(0,false,0,true));
         _container.addChild(UnknownVarFromTextualButtonPreset_TextPreset_1.window);
         _container.addEventListener("WME_CLICK",onClick);
         _container.mouseThreshold = 0;
      }
      
      public function set text(param1:String) : void
      {
         UnknownVarFromTextualButtonPreset_TextPreset_1.text = param1;
      }
      
      private function onClick(param1:WindowMouseEvent) : void
      {
         UnknownVarFromTextualButtonPreset_Function_1();
      }
      
      override public function get window() : IWindowModel
      {
         return _container;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         _container.width = param1;
      }
      
      override public function hasStaticWidth() : Boolean
      {
         return true;
      }
      
      override public function get staticWidth() : int
      {
         return _container.width;
      }
      
      override protected function get childPresets() : Array
      {
         return [UnknownVarFromTextualButtonPreset_TextPreset_1];
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         _container.dispose();
         _container = null;
         UnknownVarFromTextualButtonPreset_TextPreset_1 = null;
         UnknownVarFromTextualButtonPreset_Function_1 = null;
      }
   }
}

