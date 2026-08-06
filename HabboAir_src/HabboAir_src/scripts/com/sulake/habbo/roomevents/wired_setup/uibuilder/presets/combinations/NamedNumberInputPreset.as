package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.combinations
{
   import com.sulake.core.runtime.exceptions.Exception;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.NumberInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.NumberInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class NamedNumberInputPreset extends WiredUIPreset
   {
      private var _container:IItemListWindow;
      
      private var UnknownVarFromNamedNumberInputPreset_TextPreset_1:TextPreset;
      
      private var UnknownVarFromNamedNumberInputPreset_NumberInputPreset_1:NumberInputPreset;
      
      public function NamedNumberInputPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:NumberInputParam, param5:String, param6:Boolean = false)
      {
         super(param1,param2,param3);
         _container = param2.createLayout("horizontal_list_view") as IItemListWindow;
         UnknownVarFromNamedNumberInputPreset_TextPreset_1 = param2.createText(param5,new TextParam(0,param6));
         UnknownVarFromNamedNumberInputPreset_TextPreset_1.window.y = param3.namedTextYOffset;
         UnknownVarFromNamedNumberInputPreset_NumberInputPreset_1 = param2.createNumberInput(param4);
         UnknownVarFromNamedNumberInputPreset_TextPreset_1.window.y = param3.namedInputOffset;
         _container.spacing = param3.genericHorizontalSpacing;
         _container.addListItem(UnknownVarFromNamedNumberInputPreset_TextPreset_1.window);
         _container.addListItem(UnknownVarFromNamedNumberInputPreset_NumberInputPreset_1.window);
         _container.height = Math.max(UnknownVarFromNamedNumberInputPreset_TextPreset_1.window.height,UnknownVarFromNamedNumberInputPreset_NumberInputPreset_1.window.height);
      }
      
      public function get value() : int
      {
         return UnknownVarFromNamedNumberInputPreset_NumberInputPreset_1.value;
      }
      
      public function set value(param1:int) : void
      {
         UnknownVarFromNamedNumberInputPreset_NumberInputPreset_1.value = param1;
      }
      
      public function reset() : void
      {
         UnknownVarFromNamedNumberInputPreset_NumberInputPreset_1.reset();
      }
      
      public function set onValueChange(param1:Function) : void
      {
         UnknownVarFromNamedNumberInputPreset_NumberInputPreset_1.onValueChange = param1;
      }
      
      override public function hasStaticWidth() : Boolean
      {
         return UnknownVarFromNamedNumberInputPreset_NumberInputPreset_1.hasStaticWidth();
      }
      
      override public function get staticWidth() : int
      {
         if(hasStaticWidth())
         {
            return _container.width;
         }
         throw new Exception("Named number input has no static width");
      }
      
      override public function get window() : IWindowModel
      {
         return _container;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         UnknownVarFromNamedNumberInputPreset_TextPreset_1.resizeToWidth(UnknownVarFromNamedNumberInputPreset_TextPreset_1.width);
         UnknownVarFromNamedNumberInputPreset_NumberInputPreset_1.resizeToWidth(param1 - UnknownVarFromNamedNumberInputPreset_NumberInputPreset_1.window.x);
      }
      
      override protected function get childPresets() : Array
      {
         return [UnknownVarFromNamedNumberInputPreset_TextPreset_1,UnknownVarFromNamedNumberInputPreset_NumberInputPreset_1];
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
         UnknownVarFromNamedNumberInputPreset_TextPreset_1 = null;
         UnknownVarFromNamedNumberInputPreset_NumberInputPreset_1 = null;
      }
   }
}

